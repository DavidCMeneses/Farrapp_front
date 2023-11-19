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
        address: result.address, 
        city: result.city, 
        preference: result.preference, 
        rating: result.rating, 
        imageUrl: result.imageUrl, 
        currentSong: CurrentSongCard(name: result.currentSong.name, author: result.currentSong.author))
      ).toList()
  );

}
