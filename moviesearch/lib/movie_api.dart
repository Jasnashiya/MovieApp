import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieService {
  final String apiKey = 'API_KEY';
  final String baseUrl = 'https://www.themoviedb.org/documentation/api';

  Future<List<Movie>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}