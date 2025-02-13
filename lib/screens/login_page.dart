import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/screens/home_page.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/services/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formGlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Instancia del servicio de autenticación
  final AuthService _authService =
      AuthService(storageService: StorageService());

  final _usersProvider = UserProvider();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      if (!_formGlobalKey.currentState!.validate()) {
        return;
      }
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final success = await _authService.login(email, password);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        final futureUsersList = await _usersProvider.getUser();
        // Si el login es exitoso, navega a la pantalla principal o donde requieras
        context.go("/home");
      } else {
        setState(() {
          _errorMessage = 'Error al iniciar sesión, verifica tus credenciales.';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
                child: Opacity(
              opacity: 0.3,
              child:
                  Image.asset('imgs/background_image.jpg', fit: BoxFit.cover),
            )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: ClipOval(
                        child: Container(
                          width: 180,
                          height: 180,
                          alignment: Alignment.center,
                          child:
                              Image.asset('imgs/logo.png', fit: BoxFit.cover),
                        ),
                      )),
                      const SizedBox(height: 40),
                      const Text(
                        'Bienvenido a PINAF',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        child: Form(
                          key: _formGlobalKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Flex(
                                  direction: Axis.vertical,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Usuario o Email',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        errorStyle: TextStyle(
                                            fontSize: theme.textTheme.bodyMedium
                                                ?.fontSize),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'El campo es requerido';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Contraseña',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        suffixIcon:
                                            const Icon(Icons.remove_red_eye),
                                        errorStyle: TextStyle(
                                            fontSize: theme.textTheme.bodyMedium
                                                ?.fontSize),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'El campo es requerido';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 40),
                                    Flex(
                                      direction: Axis.vertical,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            if (_errorMessage != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: Text(
                                                  _errorMessage!,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            FilledButton(
                                              onPressed:
                                                  _isLoading ? null : _login,
                                              style: FilledButton.styleFrom(
                                                  fixedSize: Size.fromWidth(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                              )),
                                              child: _isLoading
                                                  ? const CircularProgressIndicator()
                                                  : const Text(
                                                      'Iniciar sesión'),
                                            ),
                                            const SizedBox(height: 16),
                                            OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      colorScheme.onPrimary,
                                                  fixedSize: Size.fromWidth(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.6,
                                                  )),
                                              child: const Text('Registrarse'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
