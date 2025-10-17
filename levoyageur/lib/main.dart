import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livre Interactif',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LivrePage(),
    );
  }
}

class LivrePage extends StatefulWidget {
  const LivrePage({super.key});

  @override
  State<LivrePage> createState() => _LivrePageState();
}

class _LivrePageState extends State<LivrePage> {
  String currentPage = "start";

  final Map<String, Map<String, dynamic>> story = {
    "start": {
      "text": "Tu es devant une grotte mystérieuse. Que fais-tu ?",
      "choices": {
        "Entrer dans la grotte": "page1",
        "Contourner la grotte": "page2",
      }
    },
    "page1": {
      "text": "Tu entres dans la grotte et tu trouves un trésor caché.",
      "choices": {
        "Continuer": "page3",
      }
    },
    "page2": {
      "text": "Tu contournes la grotte et rencontres un ruisseau.",
      "choices": {
        "Continuer": "page3",
      }
    },
    "page3": {
      "text": "L’aventure continue…",
      "choices": {}
    }
  };

  @override
  Widget build(BuildContext context) {
    final page = story[currentPage]!;

    return Scaffold(
      appBar: AppBar(title: const Text('Livre Interactif')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              page["text"],
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...page["choices"].entries.map((entry) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentPage = entry.value;
                  });
                },
                child: Text(entry.key),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
