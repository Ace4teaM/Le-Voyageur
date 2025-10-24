import 'package:flutter/material.dart';
import 'package:levoyageur/game_data_manager.dart';
import 'histoire.dart';
import 'package:animate_do/animate_do.dart';
import 'package:page_transition/page_transition.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  AccueilState createState() => AccueilState();
}

class AccueilState extends State<Accueil> {
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image de fond
        SizedBox.expand(
          child: Image.asset('assets/images/Background.png', fit: BoxFit.cover),
        ),

        // Image d'accueil
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              showButton = true; //affiche le bouton immédiattement
            });
          },
          child: SizedBox.expand(
            child: Image.asset(
              "assets/images/Accueil.png",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

        // Titre animé
        BounceInDown(
          duration: Duration(milliseconds: 4000), // durée animation
          child: Align(
            alignment: Alignment(0, 0.5), // Décale vers le bas
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/images/Titre.png", fit: BoxFit.fill),
            ),
          ),
        ),

        // Signature
        Positioned(
          top: 90,
          right: 20,
          child: FadeIn(
            duration: Duration(milliseconds: 4000),
            child: SizedBox(
              height: 50,
              child: Image.asset(
                "assets/images/Signature.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),

        // Bouton de menu en haut à droite
        Positioned(
          top: 40,
          right: 20,
          child: FloatingActionButton(
            heroTag: "btnMenu",
            onPressed: () {
              // action menu
            },
            child: const Icon(Icons.menu),
          ),
        ),

        // Bouton de démarrage
        if (showButton)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
              ), // distance du bord bas
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: Histoire(),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // bords arrondis
                  ),
                  backgroundColor: const Color.fromARGB(255, 119, 96, 19),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color.fromARGB(255, 80, 64, 13),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  GameDataManager().Etape == 1 ? "Démarrer" : "Continuer",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
