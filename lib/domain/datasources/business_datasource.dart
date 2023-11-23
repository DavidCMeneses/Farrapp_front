import 'package:farrap/domain/entities/establishment_result.dart';

abstract class BusinessDatasource {

  Future<EstablishmentResult> getEstablishmentResultSearch(String token, int page);
}