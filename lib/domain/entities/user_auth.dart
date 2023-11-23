import 'package:farrap/presentation/widgets/user_type.dart';

class UserAuth {

  //final String userName;
  UserType? userType;
  final String token;

  UserAuth({
    //required this.userName,
    this.userType = UserType.client,
    required this.token
  });

}
