import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formGlobalKey = GlobalKey<FormState>();

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
                                            FilledButton(
                                              onPressed: () {
                                                if (!_formGlobalKey
                                                    .currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomePage()));
                                              },
                                              style: FilledButton.styleFrom(
                                                  fixedSize: Size.fromWidth(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                              )),
                                              child: const Text('Ingresar'),
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
