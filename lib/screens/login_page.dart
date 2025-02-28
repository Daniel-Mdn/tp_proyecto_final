import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/widgets/custom_text_fields.dart';

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
        final futureUsersList = await _authService.getUserLogger();
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
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: Opacity(
              opacity: 0.3,
              child: Image.asset('assets/imgs/background_image.jpg',
                  fit: BoxFit.cover),
            )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Visibility(
                        visible: MediaQuery.of(context).viewInsets.bottom ==
                            0, // Se oculta si hay teclado
                        child: Flexible(
                            flex: 3,
                            child: ClipOval(
                              child: Container(
                                width: 180,
                                height: 180,
                                alignment: Alignment.center,
                                child: Image.asset('assets/imgs/logo.png',
                                    fit: BoxFit.cover),
                              ),
                            )),
                      ),
                      Flexible(
                          flex: 1,
                          child: Visibility(
                            visible: MediaQuery.of(context).viewInsets.bottom ==
                                0, // Se oculta si hay teclado

                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          )),
                      Flexible(
                          flex: 3,
                          child: Text(
                            'Bienvenido a PINAF',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: theme.textTheme.titleLarge?.fontSize,
                                fontWeight: FontWeight.bold),
                          )),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ),
                      Flexible(
                          flex: 20,
                          fit: FlexFit.tight,
                          child: Form(
                            key: _formGlobalKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                    controller: _emailController,
                                    label: 'Usuario o Email',
                                    errorStyle: TextStyle(
                                        fontSize: theme
                                            .textTheme.bodyMedium?.fontSize)),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                  width: 20,
                                ),
                                CustomTextField(
                                  controller: _passwordController,
                                  label: 'Contraseña',
                                  errorStyle: TextStyle(
                                      fontSize:
                                          theme.textTheme.bodyMedium?.fontSize),
                                  obscureText: true,
                                ),
                                const Flexible(child: SizedBox(height: 30)),
                                if (_errorMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      _errorMessage!,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                FilledButton(
                                  onPressed: _isLoading ? null : _login,
                                  style: FilledButton.styleFrom(
                                      fixedSize: Size.fromWidth(
                                    MediaQuery.of(context).size.width * 0.6,
                                  )),
                                  child: _isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text('Iniciar sesión'),
                                ),
                                const SizedBox(height: 6),
                                OutlinedButton(
                                  onPressed: () {
                                    context.push("/registro");
                                  },
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: colorScheme.onPrimary,
                                      fixedSize: Size.fromWidth(
                                        MediaQuery.of(context).size.width * 0.6,
                                      )),
                                  child: const Text('Registrarse'),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
