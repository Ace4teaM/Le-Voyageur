import 'package:levoyageur/game_data_grafcet.dart';
import 'package:flutter/foundation.dart';

// Classe de gestion des données de jeu persistantes
class GameDataManager extends ChangeNotifier {
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

  int _playerHealth = 100;

  int _choix = 0;

  double _grafcetStep = 1;

  // Etape
  double get Etape => _grafcetStep;
  set Etape(double value) {
    _grafcetStep = value;
    notifyListeners();
  }

  // Choix
  int get Choix => _choix;
  set Choix(int value) {
    _choix = value;
    notifyListeners();
  }

  // Health
  int get Health => _playerHealth;
  set Health(int value) {
    _playerHealth = value;
    notifyListeners();
  }

  // images States
  String get imageSelectionne {
    var basePath = "assets/images";
    if (Etape == 1) return "$basePath/LaGrange.png";
    if (Etape == 1.1) return "$basePath/Arrivee.png";
    if (Etape == 2) return "$basePath/LeReveil.png";
    if (Etape == 3) return "$basePath/Nara.png";
    if (Etape == 3.1) return "$basePath/LeCribleur.png";
    if (Etape == 4) return "$basePath/PlaneteVarg.png";
    if (Etape == 5.1) return "$basePath/Varg.png";
    if (Etape == 5.11) return "$basePath/VargLampe.png";
    if (Etape == 5.12) return "$basePath/VargAttaque.png";
    if (Etape == 5.2) return "$basePath/VieuxPortSpatial.png";
    if (Etape == 5.21) return "$basePath/CaisseCribleur.png";
    if (Etape == 5.22) return "$basePath/Entrepot.png";
    if (Etape == 10.1) return "$basePath/Fin1.png";
    if (Etape == 10.2) return "$basePath/Fin2.png";
    return "$basePath/Empty.png";
  }

  String get stepName {
    var step = Grafcet().getStep(_grafcetStep);
    if (step != null) return step.name;
    return "";
  }

  String get stepDescription {
    var step = Grafcet().getStep(_grafcetStep);
    if (step != null) return step.description;
    return "";
  }

  // 4. Méthodes pour gérer les données
  void addItem(String item) {
    if (inventory.contains(item)) return;
    int i = inventory.indexOf("Empty");
    if (i != -1) {
      inventory[i] = item;
      debugPrint("Objet ajouté : $item");
      notifyListeners(); // notifie les widgets
    }
  }

  void removeItem(String item) {
    int i = inventory.indexOf(item);
    if (i != -1) {
      inventory[i] = "Empty";
      debugPrint("Objet supprimé : $item");
      notifyListeners(); // notifie les widgets
    }
  }

  void nextChapter() {
    currentChapter++;
    notifyListeners(); // notifie les widgets
  }
}
