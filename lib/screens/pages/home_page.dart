import 'package:flutter/material.dart';
import 'package:movie_app/screens/services/movie_services.dart';
import 'package:movie_app/screens/widgets/filtered_movies_list.dart';
import 'package:movie_app/screens/widgets/horizontal_view_scroll.dart';
import 'package:movie_app/screens/widgets/movie_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<dynamic> popularMovies = [];
  List<dynamic> topRatedMovies = [];
  List<dynamic> upcomingMovies = [];
  List<dynamic> filteredMovies = [];
  bool _isSearchEmpty = true;
  bool _isLoading = true;

  void filterMovies(String query) {
    setState(() {
      filteredMovies =
          popularMovies
              .where(
                (movie) =>
                    movie['title'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList() +
          upcomingMovies
              .where(
                (movie) =>
                    movie['title'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList() +
          topRatedMovies
              .where(
                (movie) =>
                    movie['title'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      if (query.isEmpty) {
        _isSearchEmpty = true;
      } else {
        _isSearchEmpty = false;
      }
    });
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      padding: EdgeInsets.all(4),
      child: TextField(
        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              _isSearchEmpty = true;
            });
          } else
            filterMovies(value);
        },
        decoration: const InputDecoration(
          hintText: 'Search Movies',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  @override
  void initState() {
    fetchMovies();
    super.initState();
  }

  fetchMovies() async {
    MovieService movieService = MovieService();
    popularMovies = await movieService.popularMovies();
    topRatedMovies = await movieService.topRatedMovies();
    upcomingMovies = await movieService.upcomingMovies();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          searchBar(),
          _isLoading
              ? const CircularProgressIndicator()
              : !_isSearchEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Filtered Movies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FilteredMoviesList(movies: filteredMovies),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Top Rated Movies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MovieSlider(topRatedMovies: topRatedMovies),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Upcoming Movies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    HorizontalView(movies: upcomingMovies),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Popular Movies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    HorizontalView(movies: popularMovies),
                  ],
                ),
        ],
      ),
    );
  }
}
