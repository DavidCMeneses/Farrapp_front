import 'package:farrap/domain/datasources/business_datasource.dart';
import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/domain/repositories/business_repository.dart';

class BusinessRepositoryImpl extends BusinessRepository {
  final BusinessDatasource datasource;

  BusinessRepositoryImpl({required this.datasource});

  @override
  Future<EstablishmentResult> getEstablishmentResultSearch(String token, int page) {
    return datasource.getEstablishmentResultSearch(token, page);
  }
}
