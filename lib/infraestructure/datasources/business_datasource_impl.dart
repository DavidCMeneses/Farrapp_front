import 'package:dio/dio.dart';
import 'package:farrap/config/constants/environment.dart';
import 'package:farrap/domain/datasources/business_datasource.dart';
import 'package:farrap/domain/entities/establishment.dart';
import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/infraestructure/infrastructure.dart';
import 'package:farrap/infraestructure/mappers/establishment_result_mapper.dart';
import 'package:farrap/infraestructure/mappers/establishment_view_mapper.dart';
import 'package:farrap/infraestructure/models/establishment_model.dart';
import 'package:farrap/infraestructure/models/result_establishment_model.dart';

class BusinessDatasourceImpl extends BusinessDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.apiUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30)
      ));

  @override
  Future<EstablishmentResult> getEstablishmentResultSearch(String token, 
                                                          String query, 
                                                          String musicFilter, 
                                                          String establishmentFilter,
                                                          String sortedBy,
                                                          bool flag, 
                                                          int page) async {

    final Map<String, dynamic> pathParameters = {
      "filter_music" : musicFilter,
      "establishment_filter" : establishmentFilter,
      "flag" : flag,
      "sorted_by" : sortedBy,
      "query" : query
    };
    try {
      final response = await dio.get('/api/search/$page/',
          options: Options(headers: {'Authorization': 'Token $token'}),
          queryParameters: pathParameters);

      final establishmentResultModel =
          ResultEstablishment.fromJson(response.data);
      final establishmentResultEntity =
          EstablishmentResultMapper.establishmentResultToEntity(
              establishmentResultModel);
      return establishmentResultEntity;
      
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw CustomError(e.response?.data['message'] ?? 'Error inesperado');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Establishment> getEstablishmentFromId(String token, String id) async {
    try {
      
      final response = await dio.get('/api/fetch_info/$id',
          options: Options(headers: {'Authorization': 'Token $token'}));

      final establishmentModel =EstablishmentModel.fromJson(response.data);
      final establishmentEntity = EstablishmentMapper.establishmentToEntity(establishmentModel);
      return establishmentEntity;
      
      
      
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
  
  @override
  Future<bool> saveRating(String token, String establishmentId, int rating) async{
     try {
      
      await dio.put('/api/rate/', data: {
        'establishment_id': establishmentId,
        'rating': rating
      },
      options: Options(headers: {'Authorization': 'Token $token'})
      );

      return true;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 404 ){
         throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

}
