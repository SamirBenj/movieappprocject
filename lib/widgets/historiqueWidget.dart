import 'package:flutter/material.dart';

class HistoricWidget extends StatefulWidget {
  HistoricWidget({
    required this.titre,
    required this.lienImg,
    required this.year,
  });

  final String titre;
  final String lienImg;
  final String year;

  @override
  State<HistoricWidget> createState() => _HistoricWidgetState();
}

class _HistoricWidgetState extends State<HistoricWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialogDetails();
        // print('hello');
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
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
