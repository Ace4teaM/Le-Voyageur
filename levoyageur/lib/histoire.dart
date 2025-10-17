import 'package:flutter/material.dart';
import 'package:levoyageur/accueil.dart';
import 'package:levoyageur/inventaire.dart';

class Histoire extends StatefulWidget {
  const Histoire({super.key});

  @override
  HistoireState createState() => HistoireState();
}

class HistoireState extends State<Histoire> {
  String imageSelectionne = 'La Grange';

  Map<String, String> images = {
    "Couloir": "assets/images/Couloir.png",
    "Fin": "assets/images/Fin.png",
    "La Machine": "assets/images/LaMachine.png",
    "Port Spatial": "assets/images/PortSpatial.png",
    "Reveil": "assets/images/Reveil.png",
    "Empty": "assets/images/Empty.png",
    "La Grange": "assets/images/LaGrange.png",
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image de fond
        SizedBox.expand(
          child: Image.asset('assets/images/Background.png', fit: BoxFit.cover),
        ),

        // Image de l'histoire
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            child: Image.asset(images[imageSelectionne]!, fit: BoxFit.fitWidth),
          ),
        ),

        // Zone de texte en bas
        Positioned(
          bottom: 0,
          left: 0,
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: Stack(
            children: [
              Image.asset('assets/images/ZoneTexte.png', fit: BoxFit.fill),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                alignment:
                    Alignment.center, // Centre verticalement + horizontalement
                child: Text(
                  "TEXTE DE L'HISTOIRE ICI",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 99, 64, 0),
                    decorationThickness: 0,
                    fontFamily: "Serif",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        // Bouton Retour en haut à gauche
        Positioned(
          top: 40,
          left: 20,
          child: FloatingActionButton(
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
