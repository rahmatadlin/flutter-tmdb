import 'package:flutter_tmdb/services/net_utils.dart';

class RestApi {
  final NetworkUtil _util = NetworkUtil();
  final url = "https://api.themoviedb.org/3/movie";
  final urlMov =
      "https://api.themoviedb.org/3/account/21431550/favorite/movies?language=en-US&page=1&sort_by=created_at.asc";
  final urlfav = "https://api.themoviedb.org/3/account/21431550/favorite";
  
  Future<dynamic> fetchFilm(
      {required String language,
      required int page,
      required String genre,
      Map<String, String>? header}) {
    return _util
        .get("$url/$genre?language=$language-US&page=$page")
        .then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value['results'];
    });
  }

  Future<dynamic> fetchFilmFav({Map<String, String>? header}) {
    return _util
        .get(
            "$urlMov/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc")
        .then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value['results'];
    });
  }

  Future<dynamic> fetchFilmList({Map<String, String>? header}) {
    return _util
        .get("$urlMov/favorite/movies?=en-US&page=1&sort_by=created_at.as")
        .then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value['results'];
    });
  }

  Future<dynamic> detailFilm({required int id, Map<String, String>? header}) {
    return _util.get("$url/$id?language=en-US").then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value;
    });
  }

  Future<dynamic> filmFav(
      {Map<String, String>? header, var body, Map<String, String>? param}) {
    return _util
        .post(
      urlfav,
      body: body,
    )
        .then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value;
    });
  }

  Future<dynamic> filmbook(
      {Map<String, String>? header, var body, Map<String, String>? param}) {
    return _util
        .post(
      "$urlfav/watchlist",
      body: body,
    )
        .then((value) {
      if (value['status'] != false) throw value['message'];
      return value;
    });
  }
}
