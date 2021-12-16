import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoricWidget extends StatefulWidget {
  HistoricWidget({
    required this.titre,
    required this.lienImg,
    required this.year,
    required this.docId,
  });

  final String titre;
  final String lienImg;
  final String year;
  final String docId;
  @override
  State<HistoricWidget> createState() => _HistoricWidgetState();
}

//Wiget affichage de l'image du film qui à etait visite
class _HistoricWidgetState extends State<HistoricWidget> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _showDialogDetails();
        // print('hello');
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.lienImg.toString(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              db.collection('historique').doc(widget.docId).delete();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 35,
            ),
          )
        ],
      ),
    );
  }

  _showDialogDetails() {
    // return Transform.rotate(angle: math.radians(anim1.value * 360),)

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            shadowColor: Colors.white,
            elevation: 5.0,
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
