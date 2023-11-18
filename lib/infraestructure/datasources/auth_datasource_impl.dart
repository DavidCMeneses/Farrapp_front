
import 'package:dio/dio.dart';
import 'package:farrap/config/constants/environment.dart';
import 'package:farrap/config/constants/types.dart';
import 'package:farrap/domain/datasources/auth_datasource.dart';
import 'package:farrap/domain/entities/client_user.dart';
import 'package:farrap/domain/entities/establishment_user.dart';
import 'package:farrap/domain/entities/user_auth.dart';
import 'package:farrap/infraestructure/infrastructure.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

class AuthDataSourceImpl extends AuthDatasource {

  final dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10) 
      )
    );

  @override
  Future<UserAuth> checkAuthStatus(String token) async {
   
    try {
      final _ = await dio.get('/api/check_auth/',
        options: Options(
          headers: {
            'Authorization': 'Token $token'
          }
        )
      );

      final user = UserAuth(token: token);
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
  Future<UserAuth> login(String username, String password, UserType userType) async {

    try {
      final response = await dio.post('/api/login/${userType.name}/', data: {
        'username': username,
        'password': password
      },
      );

      final user = AuthUserMapper.userJsonToEntity(response.data);
      return user;
      
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

  @override
  Future<UserAuth> register(ClientUser user, UserType userType) async{
    final userToSend =  user;
    try {
      final response = await dio.post('/api/signup/${userType.name}/', data: {
        'username': userToSend.username,
        'email': userToSend.email,
        'password': userToSend.password,
        'first_name': userToSend.firstName,
        'last_name': userToSend.lastName,
        "birthday": userToSend.birthDate,
        "sex": mapGenderType[userToSend.genderType],
        "categories": userToSend.preferences.map(
          (e) => {
            "type": e.type,
            "name": e.name
          }).toList()
        
      },
      );

      final user = AuthUserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
         throw CustomError(e.response?.data['message'] ?? 'Verifique los datos' );
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
  Future<UserAuth> establishmentRegister(EstablishmentUser user, UserType userType) async {
    final userToSend =  user;
    try {
      final response = await dio.post('/api/signup/${userType.name}/', data: {
        'name': userToSend.name,
        'email': userToSend.email,
        'username': userToSend.username,
        'password': userToSend.password,
        'address': userToSend.address,
        'city': "bogota",//userToSend.city,
        "country": 'Colombia',
        "description": userToSend.description,
        "rut": int.parse(userToSend.rut),
        "verified": "false",
        "categories": userToSend.preferences.map(
          (e) => {
            "type": e.type,
            "name": e.name
          }).toList(),
        "schedules": userToSend.schedules.map(
          (e) => {
            "open": e.open,
            "close": e.close,
            "day": e.day
          }).toList(),
        
      },
      );

      final user = AuthUserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
         throw CustomError(e.response?.data['message'] ?? 'Verifique los datos' );
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
