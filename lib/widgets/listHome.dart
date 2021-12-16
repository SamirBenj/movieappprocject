import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase_io.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:movieappprocject/models/functionapi.dart';
import 'package:movieappprocject/models/movie.dart';
import 'package:movieappprocject/models/moviedetails.dart';
import 'package:movieappprocject/widgets/modalDetailsWidget.dart';

class WidgetList extends StatefulWidget {
  WidgetList(
      {required this.movies,
      required this.titre,
      required this.lienImg,
      required this.year,
      required this.imdbid});
  final List<Movie> movies;
  final String titre;
  final String lienImg;
  final String year;
  final String imdbid;
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
          "timestamp": Timestamp.now().millisecondsSinceEpoch,
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
          builder: (context) => _bottomSheetMovieDetail(widget.imdbid),
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
                // "titre": widget.titre,
                // "lienImg": widget.lienImg,
                // "year": widget.year,
                "imdID": widget.imdbid,
                'timestamp': Timestamp.now().millisecondsSinceEpoch,
              }).then((value) {
                print(value);
                MotionToast.success(
                  toastDuration: Duration(seconds: 1, milliseconds: 200),
                  description: "Votre film à bien était àjouté 😁",
                  title: "Favoris",
                  titleStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ).show(context);
              });
            },
          )
        ],
      ),
    );
  }

  Widget _bottomSheetMovieDetail(String imdid) => FutureBuilder<MovieDetails>(
      future: getDetailMovie(imdid),
      builder: (context, snapshot) {
        // print(snapshot.data!.genre);

        if (snapshot.hasData) {
          final String genre = snapshot.data?.imdbRating ?? 'nothing';
          final String imdbRating = snapshot.data?.imdbRating ?? 'nothing';
          final String director = snapshot.data?.director ?? 'nothing';
          final String plot = snapshot.data?.plot ?? 'nothing';
          final String runtime = snapshot.data?.runtime ?? 'nothing';
          final String title = snapshot.data?.title ?? 'nothing';
          final String lienImg = snapshot.data?.poster ?? 'nothing';
          final String year = snapshot.data?.year ?? 'nothing';
          return BottomSheetWidget(lienImg: lienImg, year: year, titre: title);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}
