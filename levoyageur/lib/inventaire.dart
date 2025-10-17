import 'package:flutter/material.dart';
import 'histoire.dart';

class Inventaire extends StatefulWidget {
  const Inventaire({super.key});

  @override
  InventaireState createState() => InventaireState();
}

class InventaireState extends State<Inventaire> {
  int indexSelectionne = 0;

  Map<String, String> descriptionsObjets = {
    "ObjetLampe": "Lampe à lumière noir capable de révéler des objets cachés.",
    "ObjetOscillateur":
        "Oscillateur de fréquence pour stabiliser les portails dimensionnels.",
    "ObjetNoyauEnergetique":
        "Noyau énergétique fournissant une puissance illimitée.",
    "ObjetCarteMemoire":
        "Carte mémoire contenant des données cruciales pour la mission.",
    "Empty": "Emplacement vide.",
  };

  List<String> objets = [
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image de fond
        SizedBox.expand(
          child: Image.asset('assets/images/Background.png', fit: BoxFit.cover),
        ),

        // Grille des objets
        Container(
          margin: const EdgeInsets.only(top: 130),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment:
              Alignment.topCenter, // Centre verticalement + horizontalement
          child: SizedBox(
            width: 300, // largeur de la grille
            height: 400, // hauteur de la grille
            child: GridView.count(
              crossAxisCount: 3, // 3 colonnes
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () {
                    indexSelectionne = index;
                    setState(() {});
                  },
                  onDoubleTap: () => print("Double tap Case $index cliquée"),
                  onLongPress: () => print("Appui long Case $index cliquée"),
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/CaseInventaire.png',
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            'assets/images/${objets[index]}.png',
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
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
                  "${descriptionsObjets[objets[indexSelectionne]]}",
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

        // Texte "Inventaire" en haut au centre
        Positioned(
          top: 45,
          left: 100,
          right: 0,
          child: Text(
            'Inventaire',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decorationThickness: 0,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  color: Colors.black,
                ),
              ],
            ),
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
                MaterialPageRoute(builder: (context) => Histoire()),
              );
            },
            child: const Icon(Icons.navigate_before),
          ),
        ),
      ],
    );
  }
}
