//
// Implémente le mécanisme de grafcet pour le déroulement de l'histoire
//
import 'package:flutter/rendering.dart';
import 'package:levoyageur/game_data_manager.dart';

class Step {
  String name;
  String description;

  Step({required this.name, this.description = ""});
}

class Transition {
  double from;
  double to;
  final bool Function() condition;

  Transition({required this.from, required this.to, required this.condition});
}

class Grafcet {
  // 1. Instance unique (Singleton)
  static final Grafcet _instance = Grafcet._internal();
  factory Grafcet() => _instance;

  final Map<double, Step> _steps = {}; // Remplace decimal par double
  final List<double> _initialSteps = [];
  final List<Transition> _transitions = [];

  // Getter / Setter
  int get PV => GameDataManager().Health;
  set PV(int value) => GameDataManager().Health = value;

  bool get Lampe => GameDataManager().inventory.contains("ObjetLampe");
  set Lampe(bool value) => value
      ? GameDataManager().addItem("ObjetLampe")
      : GameDataManager().removeItem("ObjetLampe");

  bool get Oscillateur =>
      GameDataManager().inventory.contains("ObjetOscillateur");
  set Oscillateur(bool value) => value
      ? GameDataManager().addItem("ObjetOscillateur")
      : GameDataManager().removeItem("ObjetOscillateur");

  bool get NoyauEnergetique =>
      GameDataManager().inventory.contains("ObjetNoyauEnergetique");
  set NoyauEnergetique(bool value) => value
      ? GameDataManager().addItem("ObjetNoyauEnergetique")
      : GameDataManager().removeItem("ObjetNoyauEnergetique");

  bool get CarteMemoire =>
      GameDataManager().inventory.contains("ObjetCarteMemoire");
  set CarteMemoire(bool value) => value
      ? GameDataManager().addItem("ObjetCarteMemoire")
      : GameDataManager().removeItem("ObjetCarteMemoire");

  bool get ChoixA => GameDataManager().Choix == 1;
  bool get ChoixB => GameDataManager().Choix == 2;

  bool get OK => GameDataManager().Choix == 0;

  Grafcet._internal() {
    // Définition des étapes
    addStep(1, Step(name: "Introduction"), initial: true);
    addStep(2, Step(name: "Entrer en douce"));
    addStep(2.1, Step(name: "Flash lumineux"));
    addStep(2.2, Step(name: "Silence mortel"));
    addStep(3, Step(name: "Négocier avec les contrebandiers"));
    addStep(3.1, Step(name: "La livraison"));
    addStep(3.2, Step(name: "Le vol"));
    addStep(4, Step(name: "La poursuite continue..."));
    addStep(4.1, Step(name: "L'Epreuve de l'Equilibre"));
    addStep(4.11, Step(name: "Lenteur et équilibre"));
    addStep(4.12, Step(name: "Vitesse et risque"));
    addStep(4.2, Step(name: "Infiltration"));
    addStep(4.21, Step(name: "Furtivité réussie"));
    addStep(4.22, Step(name: "Le piratage tourne mal"));
    addStep(5, Step(name: "Une carte révélée"));
    addStep(5.1, Step(name: "Xeros Prime"));
    addStep(5.11, Step(name: "Marchand d'antiquités"));
    addStep(5.12, Step(name: "Tentative d'évasion"));
    addStep(5.2, Step(name: "Rejoindre Nara"));
    addStep(5.21, Step(name: "Tentative de synthèse"));
    addStep(5.22, Step(name: "La dernière quête"));
    addStep(6, Step(name: "Retour ou destinée nouvelle"));
    addStep(6.1, Step(name: "FIN 1"));
    addStep(6.2, Step(name: "FIN 2"));

    // Définition des transitions
    addTransition(1, 2, () => ChoixA);
    addTransition(2, 2.1, () => ChoixA);
    addTransition(2, 2.2, () => ChoixB);
    addTransition(2.1, 4, () => OK);
    addTransition(2.2, 4, () => OK);
    addTransition(1, 3, () => ChoixB);
    addTransition(3, 3.1, () => ChoixA);
    addTransition(3, 3.2, () => ChoixB);
    addTransition(3.1, 4, () => OK);
    addTransition(3.2, 4, () => OK);
    addTransition(4, 4.1, () => ChoixA);
    addTransition(4.1, 4.11, () => ChoixA);
    addTransition(4.1, 4.12, () => ChoixB);
    addTransition(4.11, 5, () => OK);
    addTransition(4.12, 5, () => OK);
    addTransition(4, 4.2, () => ChoixB);
    addTransition(4.2, 4.21, () => ChoixA);
    addTransition(4.2, 4.22, () => ChoixB);
    addTransition(4.21, 5, () => OK);
    addTransition(4.22, 5, () => OK);
    addTransition(5, 5.1, () => ChoixA);
    addTransition(5.1, 5.11, () => ChoixA);
    addTransition(5.1, 5.12, () => ChoixB);
    addTransition(5.11, 6, () => OK);
    addTransition(5.12, 6, () => OK);
    addTransition(5, 5.2, () => ChoixB);
    addTransition(5.2, 5.21, () => ChoixA);
    addTransition(5.2, 5.22, () => ChoixB);
    addTransition(5.21, 6, () => OK);
    addTransition(5.22, 6, () => OK);
    addTransition(6, 6.1, () => ChoixA);
    addTransition(6, 6.2, () => ChoixB);
  }

  // Obtient une étape
  Step? getStep(double number) {
    if (!_steps.containsKey(number)) {
      debugPrint("L'étape $number n'existe pas.");
      return null;
    }
    return _steps[number];
  }

  // Ajoute une étape
  void addStep(double number, Step step, {bool initial = false}) {
    if (_steps.containsKey(number)) {
      throw ArgumentError("L'étape $number existe déjà.");
    }
    _steps[number] = step;

    if (initial) {
      _initialSteps.add(number);
    }
  }

  // Ajoute une transition
  void addTransition(double from, double to, bool Function() condition) {
    if (!_steps.containsKey(from) || !_steps.containsKey(to)) {
      throw ArgumentError("Les étapes source ou destination n'existent pas.");
    }

    _transitions.add(Transition(from: from, to: to, condition: condition));
  }

  // Récupération de toutes les étapes
  Iterable<MapEntry<double, Step>> getAllSteps() => _steps.entries;

  // Récupération de toutes les transitions
  Iterable<Transition> getAllTransitions() => _transitions;

  // Récupération des transitions
  Iterable<Transition> getTransitions(double fromStep) =>
      _transitions.where((t) => (t.from == fromStep));
}
