import 'dart:convert';
import 'package:movieappprocject/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movieappprocject/models/moviedetails.dart';

// class ApiFunctions {
//La fonction retournera une list des film qui la pu rechercher graçe au mot renseigné par l'utilisateur qui est en paramètre
Future<List<Movie>> getMovies(keyword) async {
  String url = 'http://www.omdbapi.com/?s=$keyword&apikey=4192163e';
  print(url);
  final response = await http.get(
    Uri.parse(url),
  );
  if (response.statusCode == 200) {
    Map data = json.decode(response.body);
    print('data from function api' + data.toString());

    if (data['Response'] == "True") {
      print("data is TRUE");
      var list = (data['Search'] as List)
          .map((item) => new Movie.fromJson(item))
          .toList();
      return list;
    } else {
      throw Exception("Error");
    }
  } else {
    throw Exception("Something wrong");
  }
}

//La fonction affichere les film de joker pour la page d'accceil
Future<List<Movie>> getJsonMovie() async {
  final String url = "http://www.omdbapi.com/?s=joker&apikey=4192163e";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["Search"];
    return list.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception("Failed to load movie");
  }
}

//La fonction de recupere les detail du film graçe à son imdbID
Future<MovieDetails> getDetailMovie(imdidValue) async {
  final urlDetail = "http://www.omdbapi.com/?i=$imdidValue&apikey=4192163e";

  final responseDetail = await http.get(Uri.parse(urlDetail));
  if (responseDetail.statusCode == 200) {
    return MovieDetails.fromJSON(jsonDecode(responseDetail.body));
  } else {
    throw Exception("Erreur dans la fonctions");
  }
}
