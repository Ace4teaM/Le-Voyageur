import 'package:flutter/material.dart';
import 'accueil.dart';
import 'package:provider/provider.dart';
import 'package:levoyageur/game_data_manager.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => GameDataManager(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Voyageur',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Accueil(),
    );
  }
}
