import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/helpers/app_colors.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/search_provider.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/services/user_provider.dart';
import 'package:tp_proyecto_final/widgets/app_bar_widget.dart';
import 'package:tp_proyecto_final/widgets/bottom_navigator_widget.dart';
import 'package:tp_proyecto_final/widgets/drawer_widget.dart';
import 'package:tp_proyecto_final/widgets/search_with_autocomplete.dart';
import 'package:tp_proyecto_final/widgets/section_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final AuthService _authService =
      AuthService(storageService: StorageService());

  // late Future<UserModel> userLogged;
  late Future<List<UserModel>> futureUsersList;

  @override
  void initState() {
    super.initState();
    // var usersProvider = UserProvider();
    // futureUsersList = usersProvider.getUsers();
    // userLogged = _authService.getUserLogger();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SearchWithAutocompleteInput<UserModel>(
              fetchFunction: userProvider.getUsers,
              displayStringForOption: (UserModel user) => user.nombre,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              // Flechas arriba/abajo
              Icon(Icons.swap_vert, color: theme.colorScheme.primary),
              // Texto principal
              Text(
                "Nombre",
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Ocupa el espacio restante para alinear a la derecha el ícono
              Spacer(),

              // Ícono de 'arrastre' o de menú
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
                    child: Container(
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
                        print("Seleccionado: $user");
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                )));
              },
            ),
          ])),
      bottomNavigationBar: const BottomNavigatorBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
