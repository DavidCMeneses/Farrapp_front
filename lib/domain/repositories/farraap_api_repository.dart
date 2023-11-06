
import 'package:farrap/domain/datasources/farraap_api.dart';

abstract class FarraapApiRepository {

  Future<String> getEstablishment({required int id});

}