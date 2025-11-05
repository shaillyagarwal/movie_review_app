import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieService {
  Future<List<dynamic>> popularMovies() async {
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmI3MzkwYjE4YTc2ZGNjNzMxNDc4NjM3OTZlYTA1NyIsIm5iZiI6MTc2MDI3NjY0My42MjQsInN1YiI6IjY4ZWJiMGEzZWUyY2U3OGI3MzhhYWNlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gIFW55m9N-k8O-m2WOAdmDWlpq_3YsDB-eAg0kEG-TY',
      'accept': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(response.body.toString());
      return (json.decode(response.body))['results'];
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> topRatedMovies() async {
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmI3MzkwYjE4YTc2ZGNjNzMxNDc4NjM3OTZlYTA1NyIsIm5iZiI6MTc2MDI3NjY0My42MjQsInN1YiI6IjY4ZWJiMGEzZWUyY2U3OGI3MzhhYWNlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gIFW55m9N-k8O-m2WOAdmDWlpq_3YsDB-eAg0kEG-TY',
      'accept': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body))['results'];
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> upcomingMovies() async {
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmI3MzkwYjE4YTc2ZGNjNzMxNDc4NjM3OTZlYTA1NyIsIm5iZiI6MTc2MDI3NjY0My42MjQsInN1YiI6IjY4ZWJiMGEzZWUyY2U3OGI3MzhhYWNlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gIFW55m9N-k8O-m2WOAdmDWlpq_3YsDB-eAg0kEG-TY',
      'accept': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body))['results'];
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> similarMovies(int movieId) async {
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmI3MzkwYjE4YTc2ZGNjNzMxNDc4NjM3OTZlYTA1NyIsIm5iZiI6MTc2MDI3NjY0My42MjQsInN1YiI6IjY4ZWJiMGEzZWUyY2U3OGI3MzhhYWNlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gIFW55m9N-k8O-m2WOAdmDWlpq_3YsDB-eAg0kEG-TY',
      'accept': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}/similar?language=en-US&page=1',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body))['results'];
    } else {
      throw Exception('Error');
    }
  }
}
