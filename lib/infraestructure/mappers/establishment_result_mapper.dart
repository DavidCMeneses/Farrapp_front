import 'package:farrap/domain/entities/establishment_card.dart';
import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/domain/entities/current_song.dart';
import 'package:farrap/infraestructure/models/result_establishment_model.dart';


class EstablishmentResultMapper {


  static EstablishmentResult establishmentResultToEntity( ResultEstablishment resultEstablishment) => EstablishmentResult(
    totalPages: resultEstablishment.totalPages, 
    establishments: resultEstablishment.results.map(
      (result) => EstablishmentCard(
        name: result.name, 
        id: result.id,
        address: result.address, 
        city: result.city, 
        preference: result.preference, 
        rating: result.rating > 0 ? result.rating : 3, 
        imageUrl: result.imageUrl, 
        currentSong: CurrentSongCard(name: result.currentSong.name, author: result.currentSong.author, url: result.currentSong.url?? "https://open.spotify.com/track/1mmR1F48d1taWksNH9mQqa?si=0b4c38bfeb984226"))
      ).toList()
  );

}
