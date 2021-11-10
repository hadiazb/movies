import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/src/models/models.dart';
import 'package:peliculas_app/src/models/movie.dart';

// Nosotros
import 'package:peliculas_app/src/models/now_playing_response.dart';
import 'package:peliculas_app/src/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'ca911080e9c4d4c6fe846e025bea59db';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayongResponse = NowPlayongResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayongResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final credictsResponse = CredictsResponse.fromJson(jsonData);

    moviesCast[movieId] = credictsResponse.cast;

    return credictsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }
}
