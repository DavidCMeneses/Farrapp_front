
import 'package:farrap/domain/entities/client_user.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

import '../entities/user_auth.dart';

abstract class AuthRepository {

  Future<UserAuth> login( String email, String password, UserType userType);
  Future<UserAuth> register( ClientUser user, UserType userType);
  Future<UserAuth> checkAuthStatus( String token );

}
