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
        totalPages: json["pages"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
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
        currentSong: CurrentSong.fromJson(json["song"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
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
    final String? url;

    CurrentSong({
        required this.name,
        required this.author,
        this.url
    });

    factory CurrentSong.fromJson(Map<String, dynamic> json) => CurrentSong(
        name: json["track_name"],
        author: json["artist_name"],
        url: json["track_url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
    };
}