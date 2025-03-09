import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/model/certification_form_model.dart';
import 'package:tp_proyecto_final/model/profesional_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/modal_service.dart';
import 'package:tp_proyecto_final/widgets/certification_form_modal.dart';

class CompleteProfesionalRegistrationPage extends StatefulWidget {
  final Map<String, dynamic> formData;
  final TipoProfesional specialty;

  const CompleteProfesionalRegistrationPage(
      {super.key, required this.formData, required this.specialty});

  @override
  State<CompleteProfesionalRegistrationPage> createState() =>
      _CompleteProfesionalRegistrationPageState();
}

class _CompleteProfesionalRegistrationPageState
    extends State<CompleteProfesionalRegistrationPage> {
  final List<CertificationForm> certifications = [];
  final ModalService modalservice = ModalService();

  Future<void> addCertification() async {
    final certification = await showCertificationFormModal(context);
    if (certification != null) {
      setState(() {
        certifications.add(certification);
      });
    }
  }

  Future<void> createProfesional() async {
    final authProvider = Provider.of<AuthService>(context, listen: false);

    if (certifications.isEmpty) {
      var confirmAction = await modalservice.showConfirmationDialog(
          context,
          'Confirmación',
          'No cargaste ninguna certificacion. ¿Quieres continuar?');
      if (confirmAction != null && confirmAction == false) {
        return;
      }
    }

    // final List<Map<String, dynamic>> jsonData =
    //     certifications.map((cert) => cert.toJson()).toList();

    ProfesionalModel body = ProfesionalModel(
        id: 0,
        nombre: widget.formData["nombre"],
        apellido: widget.formData["apellido"],
        email: widget.formData["username"],
        sexo: widget.formData["sexo"],
        fechaNacimiento: widget.formData["fechaNacimiento"],
        telefono: widget.formData["telefono"],
        role: widget.formData["role"],
        password: widget.formData["password"],
        specialty: widget.specialty,
        sportsTag: "Ninguna");

    final response = await authProvider.createUser(body);
    if (response) {
      var snackbar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro completado')),
      );
      snackbar.closed.whenComplete(() => context.go('/home'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creando el usuario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono superior
              Image.asset(
                'assets/imgs/logo.png',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 16),

              // Título
              const Text(
                'Completa tu perfil con tu formación y certificados!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // Botón agregar experiencia
              OutlinedButton.icon(
                onPressed: addCertification,
                icon: const Icon(Icons.add),
                label: const Text('Agregar experiencia'),
              ),

              const SizedBox(height: 16),

              // Sección de formación
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Formación',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 8),

              // Tarjeta de formación vacía
              Expanded(
                child: certifications.isEmpty
                    ? Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(Icons.school, color: Colors.black54),
                                SizedBox(width: 8),
                                Text(
                                  'Agrega tu primer experiencia o formación.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: certifications.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final cert = certifications[index];
                          return ListTile(
                              tileColor: theme.colorScheme.surface,
                              title: Text(cert.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Curso en ${cert.institution} - ${cert.inProgress ? 'En curso' : cert.endDate?.year}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {},
                                  //   child: const Text(
                                  //     "Ver Certificado",
                                  //     style: TextStyle(
                                  //         color: Colors.blue,
                                  //         fontSize: 12,
                                  //         fontWeight: FontWeight.w500),
                                  //   ),
                                  // ),
                                ],
                              ),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 18),
                                    onPressed: () async {
                                      final updatedCert =
                                          await showCertificationFormModal(
                                        context,
                                        cert,
                                      );

                                      if (updatedCert != null) {
                                        setState(() {
                                          certifications[index] =
                                              updatedCert; // 🔹 Actualizamos la lista
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 18, color: Colors.red),
                                    onPressed: () async {
                                      bool? confirmDelete = await modalservice
                                          .showConfirmationDialog(
                                        context,
                                        'Eliminar Certificación',
                                        '¿Estás seguro de que quieres eliminar este certificado?',
                                      );

                                      if (confirmDelete == true) {
                                        setState(() {
                                          certifications.removeAt(index);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ));
                        }),
              ),

              const Spacer(),

              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      var resp = await authService.logout(context);
                      if (resp) {
                        if (!context.mounted) return;
                        context.go('/login');
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Volver al login'),
                  ),
                  FilledButton(
                    onPressed: createProfesional,
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
