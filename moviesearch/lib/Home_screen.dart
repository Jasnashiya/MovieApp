import 'package:flutter/material.dart';
import 'movie_api.dart';
import 'movie.dart';

class Home_Screen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_Screen> {
  final MovieService _movieService = MovieService();
  List<Movie> _movies = [];
  bool _isLoading = false;

  void _searchMovies(String query) async {
    setState(() {
      _isLoading = true;
    });
    final movies = await _movieService.fetchMovies(query);
    setState(() {
      _movies = movies;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: _searchMovies,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        final movie = _movies[index];
                        return ListTile(
                          leading: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                          title: Text(movie.title),
                          subtitle: Text(movie.overview),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}