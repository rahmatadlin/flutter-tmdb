class Results {
  int? id;
  String? posterPath;
  String? title;

  Results({
    this.id,
    this.posterPath,
    this.title,
  });

  Results.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    title = json['title'];
  }
}

class Details {
  String? title;
  String? backDropPath;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  double? voteAverage;

  Details({
    this.title,
    this.backDropPath,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
  });

  // Factory constructor to create an instance from JSON
  Details.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    backDropPath = json['backdrop_path'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    voteAverage = (json['vote_average'] as num?)?.toDouble();
  }
}
