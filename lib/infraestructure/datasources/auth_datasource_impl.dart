
import 'package:dio/dio.dart';
import 'package:farrap/config/constants/environment.dart';
import 'package:farrap/domain/datasources/auth_datasource.dart';
import 'package:farrap/domain/entities/user_auth.dart';
import 'package:farrap/infraestructure/infrastructure.dart';

class AuthDataSourceImpl extends AuthDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<UserAuth> checkAuthStatus(String token) async {
    
    try {
      
      final response = await dio.get('/api/check_auth',
        options: Options(
          headers: {
            'Authorization': token
          }
        )
      );

      final user = AuthUserMapper.userJsonToEntity(response.data);
      return user;


    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<UserAuth> login(String email, String password) async {
    
    try {
      final response = await dio.post('/api/login', data: {
        'email': email,
        'password': password
      });

      final user = AuthUserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
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

  @override
  Future<UserAuth> register(Map<String,dynamic> user) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}
