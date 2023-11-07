
import '../entities/user_auth.dart';

abstract class AuthRepository {

  Future<UserAuth> login( String email, String password );
  Future<UserAuth> register( Map<String,dynamic> user );
  Future<UserAuth> checkAuthStatus( String token );

}
