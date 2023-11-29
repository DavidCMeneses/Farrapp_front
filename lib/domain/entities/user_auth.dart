import 'package:farrap/presentation/widgets/user_type.dart';

class UserAuth {

  final int? id;
  UserType? userType;
  final String token;

  UserAuth({
    this.id,
    this.userType = UserType.client,
    required this.token
  });

}
