import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieappprocject/models/movie.dart';

class WidgetList extends StatefulWidget {
  WidgetList({
    required this.movies,
    required this.titre,
    required this.lienImg,
    required this.year,
  });
  final List<Movie> movies;
  final String titre;
  final String lienImg;
  final String year;
  @override
  State<WidgetList> createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  final db = FirebaseFirestore.instance;
  @override
  void setState(VoidCallback fn) {
    FirebaseDatabase.instance;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance.collection("historique").add({
          "titre": widget.titre,
          "lienImg": widget.lienImg,
          "year": widget.year,
        });
        showModalBottomSheet(
          // isDismissible: false,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          builder: (context) => _bottomSheetMovieDetail(
              widget.lienImg, widget.titre, widget.year),
        );
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
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.add),
            onPressed: () {
              db.collection("favorites").add({
                "titre": widget.titre,
                "lienImg": widget.lienImg,
                "year": widget.year,
              });
            },
          )
        ],
      ),
    );
  }

  Widget _bottomSheetMovieDetail(String lienImg, String titre, String year) =>
      Container(
        height: MediaQuery.of(context).size.height / 2.5,
        // color: Colors.black.withAlpha(100),
        decoration: BoxDecoration(
          // color: Colors.grey,
          color: Color.fromRGBO(42, 43, 43, 100),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 120.0,
                  right: 120.0,
                  bottom: 15,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 7,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    lienImg,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titre,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                              maxLines: 4,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              year.toString(),
                              style: GoogleFonts.montserrat(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 0.0, top: 10.0),
              //   child: Row(
              //     // mainAxisAlignment: MainAxisAlignment.center,
              //     // crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  label: Text(
                    'Lecture',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                  ),
                ),
              )
              // ],
              //   ),
              // ),
            ],
          ),
        ),
      );
}
