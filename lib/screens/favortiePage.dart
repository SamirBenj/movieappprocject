import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Favoris',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: db.collection("favorites").snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Card(
                child: Text(''),
              );
            }
          }),
    );
  }
}
