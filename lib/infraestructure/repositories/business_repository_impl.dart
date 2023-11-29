import 'package:farrap/domain/datasources/business_datasource.dart';
import 'package:farrap/domain/entities/establishment.dart';
import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/domain/repositories/business_repository.dart';

class BusinessRepositoryImpl extends BusinessRepository {
  final BusinessDatasource datasource;

  BusinessRepositoryImpl({required this.datasource});

  @override
  Future<EstablishmentResult> getEstablishmentResultSearch(String token, 
                                                          String query, 
                                                          String musicFilter, 
                                                          String establishmentFilter,
                                                          String sortedBy,
                                                          bool flag, 
                                                          int page) {
    return datasource.getEstablishmentResultSearch(token, 
                                                  query, 
                                                  musicFilter, 
                                                  establishmentFilter,
                                                  sortedBy,
                                                  flag, 
                                                  page);
  }

  @override
  Future<Establishment> getEstablishmentFromId(String token, String id) {
    return datasource.getEstablishmentFromId(token, id);
  }
  
  @override
  Future<bool> saveRating(String token, String establishmentId, int rating) {
    return datasource.saveRating(token, establishmentId, rating);
  }
}
