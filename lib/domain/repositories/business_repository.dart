import 'package:farrap/domain/entities/establishment.dart';
import 'package:farrap/domain/entities/establishment_result.dart';

abstract class BusinessRepository{
  Future<EstablishmentResult> getEstablishmentResultSearch(String token, 
                                                          String query, 
                                                          String musicFilter, 
                                                          String establishmentFilter,
                                                          String sortedBy,
                                                          String flag, 
                                                          int page);
  Future<Establishment> getEstablishmentFromId(String token, String id);
  Future<bool> saveRating(String token, String establishmentId, int rating);
}