import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/helpers/app_colors.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/services/user_provider.dart';
import 'package:tp_proyecto_final/widgets/app_bar_widget.dart';
import 'package:tp_proyecto_final/widgets/drawer_widget.dart';
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
    var usersProvider = UserProvider();
    futureUsersList = usersProvider.getUsers();
    // userLogged = _authService.getUserLogger();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            FutureBuilder<List<UserModel>>(
                future: futureUsersList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var usersList = snapshot.data ?? [];
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        for (var item in usersList)
                          ListTile(
                            leading: Image.asset('imgs/without_img.png'),
                            title: Text('${item.nombre} - ${item.apellido}'),
                            subtitle: Text(item.email),
                          )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return SnackBar(content: Text('${snapshot.error}'));
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                })
          ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Rutinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar Gimnasio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Alimentación',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
