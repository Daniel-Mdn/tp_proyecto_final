import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/model/certification_form_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/widgets/certification_form_modal.dart';

class CompleteProfesionalRegistrationPage extends StatefulWidget {
  const CompleteProfesionalRegistrationPage({super.key});

  @override
  State<CompleteProfesionalRegistrationPage> createState() =>
      _CompleteProfesionalRegistrationPageState();
}

class _CompleteProfesionalRegistrationPageState
    extends State<CompleteProfesionalRegistrationPage> {
  final List<CertificationForm> certifications = [];
  final AuthService _authService =
      AuthService(storageService: StorageService());

  Future<void> addCertification() async {
    final certification = await showCertificationFormModal(context);
    if (certification != null) {
      setState(() {
        certifications.add(certification);
      });
    }
  }

  Future<void> postCertifications() async {
    if (certifications.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No hay certificaciones para enviar")),
      );
      return;
    }

    final List<Map<String, dynamic>> jsonData =
        certifications.map((cert) => cert.toJson()).toList();

    print("Enviando a API: $jsonData");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Certificaciones enviadas correctamente")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      "Ver Certificado",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 18),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 18, color: Colors.red),
                                    onPressed: () {},
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
                      var resp = await _authService.logout(context);
                      if (resp) {
                        if (!context.mounted) return;
                        context.go('/login');
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Cerrar sesión'),
                  ),
                  FilledButton(
                    onPressed: postCertifications,
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
