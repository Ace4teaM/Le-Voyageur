import 'package:flutter/rendering.dart';

//
// Implémente le mécanisme de grafcet pour le déroulement de l'histoire
//

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

  final Map<double, Step> _steps = {};
  final List<double> _initialSteps = [];
  final List<Transition> _transitions = [];

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
    addTransition(1, 2, () => true); // toujours vrai
    addTransition(2, 2.1, () => true); // toujours vrai
    addTransition(2, 2.2, () => true); // toujours vrai
    addTransition(2.1, 4, () => true); // toujours vrai
    addTransition(2.2, 4, () => true); // toujours vrai
    addTransition(1, 3, () => true); // toujours vrai
    addTransition(3, 3.1, () => true); // toujours vrai
    addTransition(3, 3.2, () => true); // toujours vrai
    addTransition(3.1, 4, () => true); // toujours vrai
    addTransition(3.2, 4, () => true); // toujours vrai
    addTransition(4, 4.1, () => true); // toujours vrai
    addTransition(4.1, 4.11, () => true); // toujours vrai
    addTransition(4.1, 4.12, () => true); // toujours vrai
    addTransition(4.11, 5, () => true); // toujours vrai
    addTransition(4.12, 5, () => true); // toujours vrai
    addTransition(4, 4.2, () => true); // toujours vrai
    addTransition(4.2, 4.21, () => true); // toujours vrai
    addTransition(4.2, 4.22, () => true); // toujours vrai
    addTransition(4.21, 5, () => true); // toujours vrai
    addTransition(4.22, 5, () => true); // toujours vrai
    addTransition(5, 5.1, () => true); // toujours vrai
    addTransition(5.1, 5.11, () => true); // toujours vrai
    addTransition(5.1, 5.12, () => true); // toujours vrai
    addTransition(5.11, 6, () => true); // toujours vrai
    addTransition(5.12, 6, () => true); // toujours vrai
    addTransition(5, 5.2, () => true); // toujours vrai
    addTransition(5.2, 5.21, () => true); // toujours vrai
    addTransition(5.2, 5.22, () => true); // toujours vrai
    addTransition(5.21, 6, () => true); // toujours vrai
    addTransition(5.22, 6, () => true); // toujours vrai
    addTransition(6, 6.1, () => true); // toujours vrai
    addTransition(6, 6.2, () => true); // toujours vrai
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
}
