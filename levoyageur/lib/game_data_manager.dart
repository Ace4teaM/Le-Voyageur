import 'package:flutter/rendering.dart';

// Classe de gestion des données de jeu persistantes
class GameDataManager {
  // 1. Instance unique (Singleton)
  static final GameDataManager _instance = GameDataManager._internal();
  factory GameDataManager() => _instance;

  // 2. Constructeur privé
  GameDataManager._internal();

  // 3. Données stockées ici
  int currentChapter = 0;
  List<String> inventory = [
    'ObjetLampe',
    'ObjetOscillateur',
    'ObjetNoyauEnergetique',
    'ObjetCarteMemoire',
    'Empty',
    'Empty',
    'Empty',
    'Empty',
    'Empty',
  ];

  int playerHealth = 100;

  // 4. Méthodes pour gérer les données
  void addItem(String item) {
    if (inventory.contains(item)) return;
    int i = inventory.indexOf("Empty");
    if (i != -1) {
      inventory[i] = item;
      debugPrint("Objet ajouté : $item");
    }
  }

  void removeItem(String item) {
    int i = inventory.indexOf(item);
    if (i != -1) {
      inventory[i] = "Empty";
      debugPrint("Objet supprimé : $item");
    }
  }

  void nextChapter() {
    currentChapter++;
  }
}
