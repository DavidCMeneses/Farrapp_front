import 'package:farrap/domain/entities/establishment_result.dart';

abstract class BusinessRepository{
  Future<EstablishmentResult> getEstablishmentResultSearch(String token, int page);
}