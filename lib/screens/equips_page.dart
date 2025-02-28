import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/widgets/app_bar_widget.dart';
import 'package:tp_proyecto_final/widgets/bottom_navigator_widget.dart';
import 'package:tp_proyecto_final/widgets/drawer_widget.dart';

class EquipsPage extends StatefulWidget {
  const EquipsPage({super.key});

  @override
  _EquipsPageState createState() => _EquipsPageState();
}

class _EquipsPageState extends State<EquipsPage> {
  List<String> teams = List.generate(10, (index) => 'Team ${index + 1}');

  void _createTeam() {
    setState(() {
      teams.add('Team ${teams.length + 1}');
    });
  }

  void _deleteTeam(int index) {
    setState(() {
      teams.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _createTeam,
              child: const Text('Create New Team'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(teams[index]),
                      subtitle: Text('Description of ${teams[index]}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTeam(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  const BottomNavigatorBarWidget(),
    );
  }
}
