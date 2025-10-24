import 'package:levoyageur/game_data_grafcet.dart';
import 'package:levoyageur/game_data_histoire.dart';
import 'package:flutter/foundation.dart';

// Classe de gestion des données de jeu persistantes
class GameDataManager extends ChangeNotifier {
  // 1. Instance unique (Singleton)
  static final GameDataManager _instance = GameDataManager._internal();
  factory GameDataManager() => _instance;

  // 2. Constructeur privé
  GameDataManager._internal() {
    reset();

    // Pour debuguage
    /*if (kDebugMode) {
      _grafcetStep = 10;
      inventory[0] = "ObjetLampe";
      inventory[1] = "ObjetOscillateur";
      inventory[2] = "ObjetNoyauEnergetique";
      inventory[3] = "ObjetCarteMemoire";
    }*/
  }

  // réinit les données à zéro
  void reset() {
    _choix = 0;
    _playerHealth = 100;
    currentChapter = 0;
    _grafcetStep = 1;
    inventory = [
      'Empty',
      'Empty',
      'Empty',
      'Empty',
      'Empty',
      'Empty',
      'Empty',
      'Empty',
      'Empty',
    ];
  }

  // 3. Données stockées ici
  late int currentChapter;
  late List<String> inventory;
  late int _playerHealth;
  late int _choix;
  late double _grafcetStep;

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
  String getTexteHistoire() {
    debugPrint("Search: ^[${Etape % 1 == 0 ? Etape.toInt() : Etape}]");

    final match = RegExp(
      "^\\[${Etape % 1 == 0 ? Etape.toInt() : Etape}\\](.*)\$",
      multiLine: true,
    ).firstMatch(StoryText.content);

    debugPrint(match.toString());
    if (match != null) {
      debugPrint("Found start at: ${match.end}");

      final matchEnd = RegExp(
        "^\\[\\d+(\\.\\d+)?\\](.*)\$",
        multiLine: true,
      ).firstMatch(StoryText.content.substring(match.end));

      if (matchEnd != null) {
        debugPrint("Found end at: ${matchEnd.start}");

        return StoryText.content
            .substring(match.end, match.end + matchEnd.start)
            .trim();
      }
      return StoryText.content.substring(match.end).trim();
    }

    return "TEXT NOT FOUND!";
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
    if (Etape == 7) return "$basePath/PlaneteVelmor.png";
    if (Etape == 7.1) return "$basePath/LeDome.png";
    if (Etape == 7.11) return "$basePath/Oscillateur.png";
    if (Etape == 8) return "$basePath/Xeros.png";
    if (Etape == 9.1) return "$basePath/XerosPrime.png";
    if (Etape == 9.2) return "$basePath/Zenthari.png";
    if (Etape == 9.12) return "$basePath/EchapeeXerosPrime.png";
    if (Etape == 9.21) return "$basePath/Explosion.png";
    if (Etape == 101) return "$basePath/Fin1.png";
    if (Etape == 102) return "$basePath/Fin2.png";
    if (Etape == 103) return "$basePath/Fin3.png";
    return "$basePath/Empty.png";
  }

  bool get asEnd {
    return Grafcet().getTransitions(_grafcetStep).isEmpty;
  }

  bool get asChoice {
    var saved = _choix;
    _choix = 0;
    for (var t in Grafcet().getTransitions(_grafcetStep)) {
      if (t.condition()) //OK ?
      {
        _choix = saved;
        return false;
      }
    }
    _choix = saved;
    return true; //dans les autres cas il faut faire un choix
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
