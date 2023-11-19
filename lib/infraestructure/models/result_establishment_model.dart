import 'dart:convert';

ResultEstablishment resultEstablishmentFromJson(String str) {
    final jsonData = json.decode(str);
    return ResultEstablishment.fromJson(jsonData);
}

String resultEstablishmentToJson(ResultEstablishment data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class ResultEstablishment {
    int totalPages;
    List<Result> results;

    ResultEstablishment({
        required this.totalPages,
        required this.results,
    });

    factory ResultEstablishment.fromJson(Map<String, dynamic> json) => ResultEstablishment(
        totalPages: json["total_pages"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final String name;
    final String address;
    final String city;
    final String preference;
    final double rating;
    final String imageUrl;
    final CurrentSong currentSong;

    Result({
        required this.name,
        required this.address,
        required this.city,
        required this.preference,
        required this.rating,
        required this.imageUrl,
        required this.currentSong,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        preference: json["preference"],
        rating: json["rating"].toDouble(),
        imageUrl: json["image_url"],
        currentSong: CurrentSong.fromJson(json["current_song"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
        "preference": preference,
        "rating": rating,
        "image_url": imageUrl,
        "current_song": currentSong.toJson(),
    };
}

class CurrentSong { 
    final String name;
    final String author;

    CurrentSong({
        required this.name,
        required this.author,
    });

    factory CurrentSong.fromJson(Map<String, dynamic> json) => CurrentSong(
        name: json["name"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
    };
}