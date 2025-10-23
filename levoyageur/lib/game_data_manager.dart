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
  bool get LaGrange => (Etape == 1);
  bool get Couloir => (Etape >= 2 && Etape < 3);
  bool get Fin => (Etape >= 3 && Etape < 3);
  bool get LaMachine => (Etape >= 4 && Etape < 4);
  bool get PortSpatial => (Etape >= 5 && Etape < 5);
  bool get Reveil => (Etape >= 6 && Etape < 6);
  bool get Empty =>
      (!LaGrange && !Couloir && !Fin && !LaMachine && !PortSpatial && !Reveil);

  String get imageSelectionne {
    if (Couloir) return "assets/images/Couloir.png";
    if (Fin) return "assets/images/Fin.png";
    if (LaMachine) return "assets/images/LaMachine.png";
    if (PortSpatial) return "assets/images/PortSpatial.png";
    if (Reveil) return "assets/images/Reveil.png";
    if (LaGrange) return "assets/images/LaGrange.png";
    return "assets/images/Empty.png";
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
