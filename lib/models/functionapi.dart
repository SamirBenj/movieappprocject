import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieappprocject/models/movie.dart';
import 'package:http/http.dart' as http;

// class ApiFunctions {
Future<List<Movie>> getMovies(keyword) async {
  String url = 'http://www.omdbapi.com/?s=$keyword&apikey=4192163e';
  print(url);
  final response = await http.get(
    Uri.parse(url),
  );
  if (response.statusCode == 200) {
    Map data = json.decode(response.body);
    print('data from function api' + data.toString());
    // final result = jsonDecode(response.body);
    // print(result);
    if (data['Response'] == "True") {
      // Iterable list = data["Search"];
      // return list.map((movie) => Movie.fromJson(movie)).toList();
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
