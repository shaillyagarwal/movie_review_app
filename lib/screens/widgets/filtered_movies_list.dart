import 'package:flutter/material.dart';
import 'package:movie_app/screens/widgets/movie_details.dart';

class FilteredMoviesList extends StatelessWidget {
  List<dynamic> movies;
  FilteredMoviesList({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetails(movie: movie),
              ),
            );
          },
          leading: Image.network(
            'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(movie['title']),
          subtitle: Text(movie['overview']),
        );
      },
    );
  }
}
