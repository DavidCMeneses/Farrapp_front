
import 'package:farrap/domain/entities/client_user.dart';
import 'package:farrap/domain/entities/establishment_user.dart';
import 'package:farrap/domain/entities/user_auth.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

abstract class AuthDatasource {

  Future<UserAuth> login( String username, String password, UserType userType);
  Future<UserAuth> register( ClientUser user, UserType userType );
  Future<UserAuth> establishmentRegister( EstablishmentUser user, UserType userType );
  Future<UserAuth> checkAuthStatus( String token );

}
