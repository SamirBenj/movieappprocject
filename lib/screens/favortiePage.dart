import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:movieappprocject/models/functionapi.dart';
import 'package:movieappprocject/models/moviedetails.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

//Cette page affiche les film ajouter par l'utilisateur
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
      //Le stream builder permet de recupere en tant réel les donnée en temps réel dans ma base ddonnée firebase

      body: StreamBuilder(
          stream: db
              .collection("favorites")
              .orderBy(
                'timestamp',
                descending: true,
              )
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              // var test = snapshot.data?['imdb'].toString();
              //Affichage des favoris depuis ma base de donées
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    String imdID = snapshot.data.docs[index]['imdID'];
                    String id = snapshot.data.docs[index].id;
                    print(imdID);
                    return FutureBuilder<MovieDetails>(
                      future: getDetailMovie(imdID),
                      builder: (context, snapshot) {
                        final String genre =
                            snapshot.data?.imdbRating ?? 'nothing';
                        final String imdbRating =
                            snapshot.data?.imdbRating ?? 'nothing';
                        final String director =
                            snapshot.data?.director ?? 'nothing';
                        final String plot = snapshot.data?.plot ?? 'nothing';
                        final String runtime =
                            snapshot.data?.runtime ?? 'nothing';
                        final String title = snapshot.data?.title ?? 'nothing';
                        final String lienImg =
                            snapshot.data?.poster ?? 'nothing';
                        final String year = snapshot.data?.year ?? 'nothing';
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('There is an error please retry'));
                        } else {
                          return Card(
                            elevation: 20.0,
                            shadowColor: Colors.red,
                            color: Colors.red,
                            margin: EdgeInsets.all(15),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              leading: Image.network(
                                lienImg,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  db
                                      .collection('favorites')
                                      .doc(id)
                                      .delete()
                                      .onError((error, stackTrace) {
                                    return Text('Erreur de base de donées');
                                  });
                                  MotionToast.success(
                                    title: 'Suppression',
                                    description:
                                        "Votre Fil à bien était supprimer 👋",
                                    titleStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).show(context);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                title,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                plot,
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade400,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  });
            }
          }),
    );
  }
}
