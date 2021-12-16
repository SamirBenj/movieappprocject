import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieappprocject/models/functionapi.dart';
import 'package:movieappprocject/models/movie.dart';
import 'package:movieappprocject/widgets/listHome.dart';

class SearchMovies extends StatefulWidget {
  SearchMovies({Key? key}) : super(key: key);

  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  // List<Movie> movie = [];
  // List<Movie> filteredMovie = [];
  final searchTextController = new TextEditingController();
  String searchText = "";
  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Recherche de Films',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.cast,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: searchTextController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    searchText = searchTextController.text;
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  });
                },
                color: Colors.grey,
              ),
              // hintText: 'Recherche un film, une serie,....',
              // hintStyle: GoogleFonts.montserrat(
              //   color: Colors.grey,
              // ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              filled: true,
              fillColor: Color.fromRGBO(51, 51, 51, 2),
              label: Text('Recherche un film, une serie,....'),
              labelStyle: GoogleFonts.montserrat(
                color: Colors.grey,
              ),
              counterStyle: TextStyle(color: Colors.red),
            ),
          ),
          if (searchText.length > 0)
            FutureBuilder<List<Movie>>(
              future: getMovies(searchText),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('has data');
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final lienImg = snapshot.data![index].poster;
                        final titre = snapshot.data![index].title;
                        final year = snapshot.data![index].year;
                        final imdID = snapshot.data![index].imdbID;
                        return Container(
                          // margin: EdgeInsets.all(7),
                          padding: EdgeInsets.all(10),
                          child: WidgetList(
                            movies: [],
                            titre: titre,
                            lienImg: lienImg,
                            year: year,
                            imdbid: imdID,
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  // print(snapshot.toString());
                  print('has error');
                  return Center(
                    child: Text("$snapshot.error"),
                  );
                }
                print('not working as well');
                // print(snapshot.data.len ?? Text('HELLO'));
                return Center(child: CircularProgressIndicator());
              },
            ),
        ],
      ),
    );
  }
}
