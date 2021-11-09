import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/src/models/movie.dart';

// Nosotros
import 'package:peliculas_app/src/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'ca911080e9c4d4c6fe846e025bea59db';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    final nowPlayongResponse = NowPlayongResponse.fromJson(response.body);
    print(nowPlayongResponse.results[0].title);

    onDisplayMovies = nowPlayongResponse.results;

    notifyListeners();
  }
}
