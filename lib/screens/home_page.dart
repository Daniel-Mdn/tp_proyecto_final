import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/widgets/section_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('PINAF'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              title: 'Rutina Activa',
              description: 'Aquí verás tu rutina actual.',
              actionText: 'Crear rutina',
              onActionPressed: () {},
            ),
            SectionCard(
              title: 'Tus entrenadores',
              description: 'Aquí verás tus entrenadores.',
              actionText: 'Agregar entrenador',
              onActionPressed: () {},
            ),
            SectionCard(
              title: 'Calorías',
              description: 'Aquí verás las calorías consumidas.',
              actionText: 'Agregar límite',
              onActionPressed: () {},
            ),
            SectionCard(
              title: 'Plan Activo',
              description: 'Aquí verás el progreso de tu plan.',
              actionText: 'Crear plan',
              onActionPressed: () {},
            ),
            SectionCard(
              title: 'Tu progreso',
              description: 'Aquí verás tu progreso según objetivos.',
              actionText: 'Agregar objetivo',
              onActionPressed: () {},
            ),
          ],
        ),
      ),
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
