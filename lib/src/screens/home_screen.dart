import 'package:flutter/material.dart';
import 'package:peliculas_app/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Peliculas en cines'),
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_off_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              CardSwiper(),
              MovieSlider(),
              MovieSlider(),
            ],
          ),
        ));
  }
}
