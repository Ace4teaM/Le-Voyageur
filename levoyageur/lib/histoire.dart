import 'package:flutter/material.dart';
import 'dart:math';
import 'package:levoyageur/accueil.dart';
import 'package:levoyageur/inventaire.dart';
import 'package:levoyageur/radial_stretch_detector.dart';
import 'package:levoyageur/game_data_manager.dart';
import 'package:levoyageur/game_data_grafcet.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:animate_do/animate_do.dart';

class Histoire extends StatefulWidget {
  const Histoire({super.key});

  @override
  HistoireState createState() => HistoireState();
}

class HistoireState extends State<Histoire> {
  String choixA = 'ICI le texte du choix A';
  String choixB = 'ICI le texte du choix B';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image de fond
        SizedBox.expand(
          child: Image.asset('assets/images/Background.png', fit: BoxFit.cover),
        ),

        // Image de l'histoire
        Consumer<GameDataManager>(
          builder: (context, game, _) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              child: Image.asset(game.imageSelectionne, fit: BoxFit.fitWidth),
            ),
          ),
        ),

        // Zone de texte de l'histoire
        Consumer<GameDataManager>(
          builder: (context, game, _) => Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: 260,
            child: Stack(
              children: [
                Image.asset('assets/images/ZoneTexte.png', fit: BoxFit.fill),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30,
                  ),
                  alignment: Alignment
                      .center, // Centre verticalement + horizontalement
                  child: SingleChildScrollView(
                    child: Text(
                      game.getTexteHistoire(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 99, 64, 0),
                        decorationThickness: 0,
                        fontFamily: "Serif",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Debug
        if (kDebugMode)
          Consumer<GameDataManager>(
            builder: (context, game, _) => Positioned(
              bottom: 300,
              left: 0,
              child: Text(
                "Etape = ${game.Etape}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  decorationThickness: 0,
                  fontFamily: "Serif",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

        // Zone de choix
        Consumer<GameDataManager>(
          builder: (context, game, _) {
            return (!game.asEnd)
                ? ZoneDeChoix()
                : GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Accueil()),
                      );
                      game.reset();
                    },
                  );
          },
        ),

        // Bouton Retour en haut à gauche
        Positioned(
          top: 40,
          left: 20,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inventaire()),
              );
            },
            child: const Icon(Icons.inventory_2_outlined),
          ),
        ),

        // Bouton de menu en haut à droite
        Positioned(
          top: 40,
          right: 20,
          child: FloatingActionButton(
            heroTag: "btnMenu",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Accueil()),
              );
            },
            child: const Icon(Icons.menu),
          ),
        ),
      ],
    );
  }
}

class ZoneDeChoix extends StatefulWidget {
  const ZoneDeChoix({super.key});

  @override
  State<ZoneDeChoix> createState() => _ZoneDeChoixState();
}

class _ZoneDeChoixState extends State<ZoneDeChoix> {
  double choixProgressA = 0.0; // 0 = pas tiré, 1 = pleine puissance
  double choixProgressB = 0.0; // 0 = pas tiré, 1 = pleine puissance

  // si l'angle se trouve dans la moitié droite
  bool isInRightHalf(double angle) {
    // Normalisation de l’angle entre -π et +π
    angle = normalizeAngle(angle);

    // Partie droite du cercle (de -90° à +90°)
    return angle >= -pi / 2 && angle <= pi / 2;
  }

  // normalise l'angle, Ramener entre -π et +π pour éviter les angles tournés plusieurs fois
  double normalizeAngle(double angle) {
    while (angle <= -pi) angle += 2 * pi;
    while (angle > pi) angle -= 2 * pi;
    return angle;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameDataManager>(
      builder: (context, game, _) {
        if (!game.asChoice) {
          return GestureDetector(
            onTap: () {
              game.Choix = 0;
              debugPrint("OK");
              for (var t in Grafcet().getTransitions(game.Etape)) {
                if (t.condition()) {
                  game.Etape = t.to;
                  debugPrint("Choix = ${game.Etape}");
                  debugPrint(
                    "...la condition est remplie ${t.from} > ${t.to}}.",
                  );
                } else {
                  debugPrint(
                    "...la condition n'est pas remplie à l'étape ${t.from} > ${t.to}} !",
                  );
                }
              }
            },
            child: Center(
              child: Transform.translate(
                offset: Offset(0, -40), // Croît avec la progression
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha(64),
                    border: Border.all(
                      color: Color.fromARGB(
                        255,
                        50,
                        50,
                        50,
                      ), // Couleur de bordure
                      width: 6, // Épaisseur de bordure
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        decorationThickness: 0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              debugPrint("Glissez pour faire un choix");
            },
            onDoubleTap: () {
              debugPrint("Glissez pour faire un choix");
            },
            child: Stack(
              children: [
                // Choix
                Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: Offset(0, 100.0), // Croît avec la progression
                    child: Text(
                      choixProgressA > 0.10
                          ? "A"
                          : choixProgressB > 0.10
                          ? "B"
                          : "",
                      style: TextStyle(
                        decorationThickness: 0,
                        color: Colors.white.withAlpha(
                          (255.0 * max(choixProgressA, choixProgressB)).toInt(),
                        ),
                        fontSize: 60 + max(choixProgressA, choixProgressB) * 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RadialStretchDetector(
                    onFullStretch: () {
                      // déclenche l'execution du grafcet
                      if (choixProgressA > 0) {
                        game.Choix = 1;
                        debugPrint("Choix A");
                      } else {
                        game.Choix = 2;
                        debugPrint("Choix B");
                      }

                      for (var t in Grafcet().getTransitions(game.Etape)) {
                        if (t.condition()) {
                          game.Etape = t.to;
                          debugPrint(
                            "...la condition est remplie ${t.from} > ${t.to}}.",
                          );
                        } else {
                          debugPrint(
                            "...la condition n'est pas remplie ${t.from} > ${t.to}} !",
                          );
                        }
                      }

                      // reinit l'etat du bouton radial
                      setState(() => choixProgressA = 0);
                      setState(() => choixProgressB = 0);
                    },
                    onReleased: () {
                      debugPrint("ACTION Annulé !");
                      setState(() => choixProgressA = 0);
                      setState(() => choixProgressB = 0);
                    },
                    onDragProgress: (double progress, double direction) {
                      if (isInRightHalf(direction)) {
                        setState(() => choixProgressB = progress);
                        setState(() => choixProgressA = 0);
                      } else {
                        setState(() => choixProgressA = progress);
                        setState(() => choixProgressB = 0);
                      }
                    },
                    child: Transform.translate(
                      offset: Offset(0, -40), // Croît avec la progression
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(64),
                          border: Border.all(
                            color: Color.fromARGB(
                              255,
                              50,
                              50,
                              50,
                            ), // Couleur de bordure
                            width: 6, // Épaisseur de bordure
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Choix",
                            style: TextStyle(
                              decorationThickness: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
