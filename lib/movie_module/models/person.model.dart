// To parse this JSON data, do
//
//     final peoplePopular = peoplePopularFromJson(jsonString);

import 'dart:convert';

PersonPopular peoplePopularFromJson(String str) => PersonPopular.fromJson(json.decode(str));

String peoplePopularToJson(PersonPopular data) => json.encode(data.toJson());

class PersonPopular {
    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    PersonPopular({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory PersonPopular.fromJson(Map<String, dynamic> json) => PersonPopular(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Result {
    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    List<KnownFor> knownFor;

    Result({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        required this.profilePath,
        required this.knownFor,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
    };
}

class KnownFor {
    bool adult;
    String? backdropPath;
    int id;
    String? name;
    String? originalName;
    String overview;
    String posterPath;
    String mediaType;
    String originalLanguage;
    List<int> genreIds;
    double popularity;
    DateTime? firstAirDate;
    bool softcore;
    double voteAverage;
    int voteCount;
    List<String>? originCountry;
    String? title;
    String? originalTitle;
    DateTime? releaseDate;
    bool? video;

    KnownFor({
        required this.adult,
        required this.backdropPath,
        required this.id,
        this.name,
        this.originalName,
        required this.overview,
        required this.posterPath,
        required this.mediaType,
        required this.originalLanguage,
        required this.genreIds,
        required this.popularity,
        this.firstAirDate,
        required this.softcore,
        required this.voteAverage,
        required this.voteCount,
        this.originCountry,
        this.title,
        this.originalTitle,
        this.releaseDate,
        this.video,
    });

    factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        originalLanguage: json["original_language"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        softcore: json["softcore"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
        title: json["title"],
        originalTitle: json["original_title"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        video: json["video"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "original_language": originalLanguage,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "softcore": softcore,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
        "title": title,
        "original_title": originalTitle,
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
    };
}