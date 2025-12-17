import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  // Stateful: perquè la llista es reordena i hem d'actualitzar l'estat.
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  final List<String> _tasques = [
    "Estudiar Flutter",
    "Fer el formulari",
    "Provar navegació",
    "Gravar vídeo (max 5 min)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("InteractiveViewer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Widget 1: InteractiveViewer (zoom/pan)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 3.0,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black12,
                    child: const Text(
                      "Fes zoom i mou aquesta targeta",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Widget 2: ReorderableListView (arrossega per reordenar)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Necessita una alçada fixa si va dins ListView
            SizedBox(
              height: 260,
              child: ReorderableListView(
                children: [
                  for (int i = 0; i < _tasques.length; i++)
                    ListTile(
                      key: ValueKey(_tasques[i]),
                      title: Text(_tasques[i]),
                      leading: const Icon(Icons.drag_handle),
                    ),
                ],
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _tasques.removeAt(oldIndex);
                    _tasques.insert(newIndex, item);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
