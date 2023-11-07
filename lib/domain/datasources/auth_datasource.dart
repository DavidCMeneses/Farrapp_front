
import 'package:farrap/domain/entities/user_auth.dart';

abstract class AuthDatasource {

  Future<UserAuth> login( String email, String password );
  Future<UserAuth> register( Map<String,dynamic> user );
  Future<UserAuth> checkAuthStatus( String token );

}
