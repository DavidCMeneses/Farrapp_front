
import 'package:farrap/domain/datasources/farraap_api.dart';
import 'package:farrap/domain/repositories/farraap_api_repository.dart';

class FarraapApiRepositoryImpl extends FarraapApiRepository {

  final FarraapApi farraapApi;

  FarraapApiRepositoryImpl({required this.farraapApi});
  
  @override
  Future<String> getEstablishment({required int id}) {
    return farraapApi.getEstablishment(id: id);
  }



}