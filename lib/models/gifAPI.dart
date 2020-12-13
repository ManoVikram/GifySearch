import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../API_KEY.dart';

class Gif {
  final String height;
  final String width;
  final String url;

  Gif({
    @required this.height,
    @required this.width,
    @required this.url,
  });
}

class Gify with ChangeNotifier {
  List<Gif> _gifs = [];

  List<Gif> get gifs {
    return [..._gifs];
  }

  int length = 0;

  Future<void> fetchGifs(String searchTerm) async {
    final url =
        "https://api.giphy.com/v1/gifs/search?api_key=$API_KEY&q=$searchTerm&limit=50&offset=0&rating=g&lang=en";
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return null;
    }

    final List<Gif> loadedGifs = [];
    length = extractedData["data"].length;
    for (var gifData in extractedData["data"]) {
      loadedGifs.add(
        Gif(
          height: gifData["images"]["fixed_height"]["height"],
          width: gifData["images"]["fixed_height"]["width"],
          url: gifData["images"]["fixed_height"]["url"],
        ),
      );
    }
    _gifs = loadedGifs;
    notifyListeners();

    print(_gifs.length);
  }
}
