
import "package:http/http.dart" as http;
import "package:flutter/foundation.dart";
import "../models/the_movie_model.dart";
import "../models/movie_detail_model.dart";
import "../models/person.model.dart";
import "../models/person_detail_model.dart";
import "../api_key.dart";

class TheMovieService {
  final baseUrl = "https://api.themoviedb.org/3/movie";

  Future<TheMovie> read() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/now_playing?language=en-US&page=1&api_key=$apiKey"),
      );
      if (response.statusCode == 200) {
        return compute(theMovieFromJson, response.body);
      } else {
        throw Exception("Error status code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieDetail> get(String movieId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$movieId?language=en-US&api_key=$apiKey"),
      );
      if (response.statusCode == 200) {
        return compute(movieDetailFromJson, response.body);
      } else {
        throw Exception("Error status code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }

  }


  Future<PersonPopular> getPopularPeople() async {
  final response = await http.get(
    Uri.parse(
      "https://api.themoviedb.org/3/person/popular?language=en-US&page=1&api_key=$apiKey",
    ),
  );

  if (response.statusCode == 200) {
    return compute(
      peoplePopularFromJson,
      response.body,
    );
  } else {
    throw Exception(
      "Error status code ${response.statusCode}",
    );
  }
}



Future<PersonDetail> getPersonDetail(String personId) async {
  try {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/person/$personId?language=en-US&api_key=$apiKey",
      ),
    );

    if (response.statusCode == 200) {
      return compute( personDetailFromJson,  response.body);
    } else {
      throw Exception(
        "Error status code ${response.statusCode}",
      );
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}


  Future<TheMovie> search(String query) async {
  try {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/search/movie?language=en-US&query=$query&page=1&api_key=$apiKey",
      ),
    );

    if (response.statusCode == 200) {
      return compute(theMovieFromJson,  response.body);
    } else {
      throw Exception(
        "Error status code ${response.statusCode}",
      );
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
}