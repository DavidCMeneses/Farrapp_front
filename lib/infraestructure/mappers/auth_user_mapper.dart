import 'package:farrap/domain/entities/user_auth.dart';


class AuthUserMapper {


  static UserAuth userJsonToEntity( Map<String,dynamic> json ) => UserAuth(
    //email: json['email'],
    userType: json['user_type'],
    token: json['token']
  );

}
