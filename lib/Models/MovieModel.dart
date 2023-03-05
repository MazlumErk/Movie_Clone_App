import 'dart:convert';

MovieDatas movieDatasFromJson(String str) =>
    MovieDatas.fromJson(jsonDecode(str));

class MovieDatas {
  MovieDatas({
    required this.page,
    required this.results,
  });
  int page;
  List<Results> results;

  factory MovieDatas.fromJson(Map<String, dynamic> json) => MovieDatas(
        page: json['page'],
        results:
            List<Results>.from(json['results'].map((x) => Results.fromJson(x))),
      );
}

class Results {
  Results({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  bool adult;
  String backdropPath;
  List<dynamic> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );
}
