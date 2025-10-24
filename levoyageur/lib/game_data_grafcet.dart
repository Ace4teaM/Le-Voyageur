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

  bool get ObjetLampe => GameDataManager().inventory.contains("ObjetLampe");
  set ObjetLampe(bool value) => value
      ? GameDataManager().addItem("ObjetLampe")
      : GameDataManager().removeItem("ObjetLampe");

  bool get ObjetOscillateur =>
      GameDataManager().inventory.contains("ObjetOscillateur");
  set ObjetOscillateur(bool value) => value
      ? GameDataManager().addItem("ObjetOscillateur")
      : GameDataManager().removeItem("ObjetOscillateur");

  bool get ObjetNoyauEnergetique =>
      GameDataManager().inventory.contains("ObjetNoyauEnergetique");
  set ObjetNoyauEnergetique(bool value) => value
      ? GameDataManager().addItem("ObjetNoyauEnergetique")
      : GameDataManager().removeItem("ObjetNoyauEnergetique");

  bool get ObjetCarteMemoire =>
      GameDataManager().inventory.contains("ObjetCarteMemoire");
  set ObjetCarteMemoire(bool value) => value
      ? GameDataManager().addItem("ObjetCarteMemoire")
      : GameDataManager().removeItem("ObjetCarteMemoire");

  bool get ChoixA => GameDataManager().Choix == 1;
  bool get ChoixB => GameDataManager().Choix == 2;

  bool get OK => GameDataManager().Choix == 0;

  Grafcet._internal() {
    // Définition des étapes
    addStep(1, Step(name: "Une faille dans le ciel"), initial: true);
    addStep(1.1, Step(name: "L'Arrivée"));
    addStep(2, Step(name: "Une langue inconnue"));
    addStep(3, Step(name: "La quête commence"));
    addStep(3.1, Step(name: "Le Cribleur"));
    addStep(4, Step(name: "Périls et décisions"));
    addStep(5.1, Step(name: "Entrer en douce"));
    addStep(5.11, Step(name: "Flash lumineux"));
    addStep(5.12, Step(name: "Silence mortel"));
    addStep(5.2, Step(name: "Négocier avec les contrebAndiers"));
    addStep(5.21, Step(name: "La livraison"));
    addStep(5.22, Step(name: "Le vol"));
    addStep(6, Step(name: "La poursuite continue..."));
    addStep(7, Step(name: "Les Abysses de Velmor"));
    addStep(7.1, Step(name: "L'Epreuve de l'Equilibre"));
    addStep(7.11, Step(name: "Lenteur et équilibre"));
    addStep(7.12, Step(name: "Vitesse et risque"));
    addStep(7.2, Step(name: "Infiltration"));
    addStep(7.22, Step(name: "Furtivité réussie"));
    addStep(7.21, Step(name: "Le piratage tourne mal"));
    addStep(8, Step(name: "Une carte révélée"));
    addStep(9.1, Step(name: "Xeros Prime"));
    addStep(9.11, Step(name: "MarchAnd d'antiquités"));
    addStep(9.12, Step(name: "Tentative d'évasion"));
    addStep(9.2, Step(name: "Rejoindre Nara"));
    addStep(9.21, Step(name: "Tentative de synthèse"));
    addStep(9.22, Step(name: "La dernière quête"));
    addStep(10, Step(name: "Le Dernier Choix"));
    addStep(101, Step(name: "FIN 1"));
    addStep(102, Step(name: "FIN 2"));
    addStep(103, Step(name: "FIN 3"));

    // Définition des transitions
    addTransition(1, 1.1, () => OK);
    addTransition(1.1, 2, () => OK);
    addTransition(2, 3, () => OK);
    addTransition(3, 3.1, () => OK);
    addTransition(3.1, 4, () => OK);
    addTransition(4, 5.1, () => ChoixA);
    addTransition(4, 5.2, () => ChoixB);
    addTransition(5.1, 5.11, () => ChoixA);
    addTransition(5.1, 5.12, () => ChoixB);
    addTransition(5.2, 5.21, () => ChoixA);
    addTransition(5.2, 5.22, () => ChoixB);
    addTransition(5.11, 6, () => OK);
    addTransition(5.12, 6, () => OK);
    addTransition(5.21, 6, () => OK);
    addTransition(5.22, 6, () => OK);
    addTransition(6, 7, () => OK);
    addTransition(7, 7.1, () => ChoixA);
    addTransition(7, 7.2, () => ChoixB);
    addTransition(7.1, 7.11, () => ChoixA);
    addTransition(7.1, 7.12, () => ChoixB);
    addTransition(7.2, 7.21, () => ChoixA);
    addTransition(7.2, 7.22, () => ChoixB);
    addTransition(7.11, 8, () => OK);
    addTransition(7.12, 8, () => OK);
    addTransition(7.21, 8, () => OK);
    addTransition(7.22, 8, () => OK);
    addTransition(8, 9.1, () => ChoixA);
    addTransition(8, 9.2, () => ChoixB);
    addTransition(9.1, 9.11, () => ChoixA);
    addTransition(9.1, 9.12, () => ChoixB);
    addTransition(9.2, 9.21, () => ChoixA);
    addTransition(9.2, 9.22, () => ChoixB);
    addTransition(9.11, 10, () => OK);
    addTransition(9.12, 10, () => OK);
    addTransition(9.21, 103, () => OK);
    addTransition(9.22, 10, () => OK);
    addTransition(
      10,
      101,
      () =>
          OK && ObjetOscillateur && ObjetCarteMemoire && ObjetNoyauEnergetique,
    );
    addTransition(
      10,
      102,
      () =>
          OK &&
          (!ObjetOscillateur || !ObjetCarteMemoire || !ObjetNoyauEnergetique),
    );
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
