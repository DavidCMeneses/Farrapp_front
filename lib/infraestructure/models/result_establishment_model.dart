import 'dart:convert';

ResultEstablishment resultEstablishmentFromJson(String str) {
  final jsonData = json.decode(str);
  return ResultEstablishment.fromJson(jsonData);
}

class ResultEstablishment {
  int totalPages;
  List<Result> results;

  ResultEstablishment({
    required this.totalPages,
    required this.results,
  });

  factory ResultEstablishment.fromJson(Map<String, dynamic> json) =>
      ResultEstablishment(
        totalPages: json["pages"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  final String name;
  final String id;
  final String address;
  final String city;
  final String preference;
  final double rating;
  final String imageUrl;
  final CurrentSong currentSong;

  Result({
    required this.name,
    required this.id,
    required this.address,
    required this.city,
    required this.preference,
    required this.rating,
    required this.imageUrl,
    required this.currentSong,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        id: '${json["id"]}',
        address: json["address"],
        city: json["city"],
        preference: json["preferences"],
        rating: json["rating"] + 0.0,
        imageUrl: json["image_url"],
        currentSong: CurrentSong.fromJson(json),
      );
}

class CurrentSong {
  final String name;
  final String author;
  final String? url;

  CurrentSong({required this.name, required this.author, this.url});

  factory CurrentSong.fromJson(Map<String, dynamic> json) {
    return CurrentSong(name: 'CuatroPunto95', author: 'Omar');
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
      };
}
