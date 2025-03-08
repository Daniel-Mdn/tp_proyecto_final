import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/search_provider.dart';
import 'package:tp_proyecto_final/services/user_provider.dart';
import 'package:tp_proyecto_final/widgets/app_bar_widget.dart';
import 'package:tp_proyecto_final/widgets/bottom_navigator_widget.dart';
import 'package:tp_proyecto_final/widgets/drawer_widget.dart';
import 'package:tp_proyecto_final/widgets/search_with_autocomplete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Widget?> futureHomeContent;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureHomeContent = getHomeByRol(); // Solo se inicializa una vez
  }

  Future<Widget?> getHomeByRol() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final ThemeData theme = Theme.of(context);

    final user = await authService.getUserSaved();
    if (user != null && user.role == TipoUsuario.profesional) {
      return Column(children: [
        SearchWithAutocompleteInput<UserModel>(
          fetchFunction: userProvider.getUsers,
          displayStringForOption: (UserModel user) => user.nombre,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(children: [
          Icon(Icons.swap_vert, color: theme.colorScheme.primary),
          Text(
            "Nombre",
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(Icons.list, color: theme.colorScheme.primary),
        ]),
        const SizedBox(
          height: 16,
        ),
        Consumer<SearchProvider<UserModel>>(
          builder: (context, searchProvider, child) {
            if (searchProvider.isLoading) {
              return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator());
            }
            if (searchProvider.suggestions.isEmpty) {
              return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text("No se encontraron resultados"));
            }
            return Expanded(
                child: ListView.separated(
              itemCount: searchProvider.suggestions.length,
              itemBuilder: (context, index) {
                final user = searchProvider.suggestions[index];
                return ListTile(
                  tileColor: theme.colorScheme.surface,
                  leading: Image.asset('assets/imgs/without_img.png'),
                  title: Text('${user.nombre} - ${user.apellido}'),
                  subtitle: Text(user.email),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    // Acción al seleccionar un ítem del listado
                    // print("Seleccionado: $user");
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                );
              },
            ));
          },
        ),
      ]);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: futureHomeContent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Container();
              }
              return snapshot.data ??
                  const Center(child: Text("No hay contenido disponible"));
            }),
      ),
      bottomNavigationBar: const BottomNavigatorBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
