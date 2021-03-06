import 'package:flutter/material.dart';

// Nosotros
import 'package:peliculas_app/src/providers/movies_provider.dart';
import 'package:peliculas_app/src/search/search_delegate.dart';
import 'package:peliculas_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    // print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Peliculas en cines'),
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search_off_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CardSwiper(
                movies: moviesProvider.onDisplayMovies,
              ),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares!',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
