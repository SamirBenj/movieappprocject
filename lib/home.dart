import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieappprocject/widgets/historiqueWidget.dart';
import 'package:movieappprocject/widgets/searchmovie.dart';
import 'models/functionapi.dart';
import 'models/movie.dart';
import 'screens/favortiePage.dart';
import 'widgets/choixOption.dart';
import 'widgets/listHome.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<Movie> _movies = <Movie>[];

  @override
  void initState() {
    super.initState();
    _getAllMovies();
    // var data = getDetailMovie('tt1375666');
  }

  //Recupere les films
  void _getAllMovies() async {
    final movies = await getJsonMovie();
    setState(() {
      _movies = movies;
    });
    // print(_movies.toList());
  }

  TextEditingController nameMovieSearch = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            //Page pour les favoris
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FavoritePage()));
          },
          icon: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            "https://cdn-icons-png.flaticon.com/512/732/732228.png",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchMovies(),
                  ),
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Roman",
                  "Action",
                  "Drama",
                  "Sci-Fi",
                ].map((filter) => ChoiceOption(text: filter)).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              height: MediaQuery.of(context).size.height * 0.00,
              thickness: 2,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Ce Que Vous Pourrait Aimer!',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          //Affichage des film que pourrais aimer l'utilisateur
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemExtent: MediaQuery.of(context).size.height * 0.3,
                scrollDirection: Axis.horizontal,
                itemCount: _movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final nomFilm = _movies[index].title;
                  final lienImg = _movies[index].poster;
                  final year = _movies[index].year;
                  final imdID = _movies[index].imdbID;
                  return WidgetList(
                    movies: [],
                    titre: nomFilm,
                    lienImg: lienImg,
                    year: year,
                    imdbid: imdID,
                  );
                },
              ),
            ),
          ),
          //Afichage de l'historique recuperé de la base de donées firebase
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Votre historique",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              //Recuperation des donées dans la base de donées firebase
              stream: db
                  .collection("historique")
                  .orderBy(
                    'timestamp',
                    descending: true,
                  )
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Il y'a une erreur");
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final lienImg = snapshot.data.docs[index]['lienImg'];
                      final nomFilm = snapshot.data.docs[index]['titre'];
                      final year = snapshot.data.docs[index]['year'];
                      final docId = snapshot.data.docs[index].id;
                      // final imdbID = snapshot.data.docs[index]['imdbID'];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: HistoricWidget(
                          titre: nomFilm,
                          lienImg: lienImg,
                          year: year,
                          docId: docId,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
