
import 'package:farrap/domain/entities/user_auth.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

abstract class AuthDatasource {

  Future<UserAuth> login( String username, String password, UserType userType);
  Future<UserAuth> register( Map<String,dynamic> user );
  Future<UserAuth> checkAuthStatus( String token );

}
