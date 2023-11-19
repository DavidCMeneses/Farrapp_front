import 'package:dio/dio.dart';
import 'package:farrap/config/constants/environment.dart';
import 'package:farrap/domain/datasources/business_datasource.dart';
import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/infraestructure/infrastructure.dart';
import 'package:farrap/infraestructure/mappers/establishment_result_mapper.dart';
import 'package:farrap/infraestructure/models/result_establishment_model.dart';

class BusinessDatasourceImpl extends BusinessDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.apiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)));

  @override
  Future<EstablishmentResult> getEstablishmentResultSearch(String token, int page) async {
    try {
      final response = await dio.get('/api/search_establishment/',
          options: Options(headers: {'Authorization': 'Token $token'}));

      final establishmentResultModel =
          ResultEstablishment.fromJson(response.data);
      final establishmentResultEntity =
          EstablishmentResultMapper.establishmentResultToEntity(
              establishmentResultModel);
      return establishmentResultEntity;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error inesperado');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
