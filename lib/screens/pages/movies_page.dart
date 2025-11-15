import 'package:flutter/material.dart';
import 'package:movie_app/screens/services/movie_services.dart';
import 'package:movie_app/screens/widgets/movie_details.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  List<dynamic> upcomingMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    MovieService movieService = MovieService();
    upcomingMovies = await movieService.upcomingMovies();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Decide column count based on screen width
    int crossAxisCount = screenWidth > 1200
        ? 5
        : screenWidth > 900
        ? 4
        : screenWidth > 600
        ? 3
        : 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Movies')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  // **Perfect movie poster ratio (vertical 2:3)**
                  childAspectRatio: 0.62,
                ),
                itemCount: upcomingMovies.length,
                itemBuilder: (context, index) {
                  final movie = upcomingMovies[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetails(movie: movie),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          // Image auto-resizes properly
                          Expanded(
                            flex: 7,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie['poster_path'] ?? movie['backdrop_path']}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),

                          // Movie Title
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                movie['title'],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenWidth < 450
                                      ? 12
                                      : screenWidth < 900
                                      ? 14
                                      : 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
