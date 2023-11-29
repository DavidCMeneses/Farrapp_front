import 'package:farrap/domain/entities/user_auth.dart';


class AuthUserMapper {


  static UserAuth userJsonToEntity( Map<String,dynamic> json ) => UserAuth(
    id: json['id'],
    userType: json['user_type'],
    token: json['token']
  );

}
