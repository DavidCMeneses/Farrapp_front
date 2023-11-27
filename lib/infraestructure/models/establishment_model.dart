
class EstablishmentModel {
    String name;
    String address;
    String city;
    String description;
    double rating;
    List<Preference> preferences;
    String imageUrl;
    PlaylistModel playlist;
    List<Schedule> schedule;
    int userRating;

    EstablishmentModel({
        required this.name,
        required this.address,
        required this.city,
        required this.description,
        required this.preferences,
        required this.rating,
        required this.imageUrl,
        required this.playlist,
        required this.schedule,
        required this.userRating,
    });

    factory EstablishmentModel.fromJson(Map<String, dynamic> json) => EstablishmentModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        description: json["description"],
        preferences: List<Preference>.from(json["categories"].map((x) => Preference.fromJson(x))),
        rating: json["rating"] + .0,
        imageUrl: json["image_url"],
        playlist: PlaylistModel.fromJson(json),
        schedule: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
        userRating: json["user_rating"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
        "description": description,
        "preferences": List<dynamic>.from(preferences.map((x) => x.toJson())),
        "rating": rating,
        "image_url": imageUrl,
        "playlist": playlist.toJson(),
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
        "user_rating": userRating,
    };
}

class PlaylistModel {
    String playlistName;
    List<Song> songs;

    PlaylistModel({
        required this.playlistName,
        required this.songs,
    });

    factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        playlistName: json["playlist_name"],
        songs: List<Song>.from(json["tracks"].map((x) => Song.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "playlist_name": playlistName,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
    };
}

class Song {
    String name;
    String author;
    String? url;

    Song({
        required this.name,
        required this.author,
        this.url
    });

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        name: json["track_name"],
        author: json["artist_name"],
        url: json["track_url"] 
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
    };
}

class Preference {
    String type;
    String name;

    Preference({
        required this.type,
        required this.name,
    });

    factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        type: json["type"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
    };
}

class Schedule {
    String day;
    String open;
    String close;

    Schedule({
        required this.day,
        required this.open,
        required this.close,
    });

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        day: json["day"],
        open: json["open"],
        close: json["close"],
    );                                                            

    Map<String, dynamic> toJson() => {
        "day": day,
        "open": open,
        "close": close,
    };
}