import 'package:farrap/domain/datasources/auth_datasource.dart';
import 'package:farrap/domain/entities/user_auth.dart';
import 'package:farrap/domain/repositories/auth_repository.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

import '../infrastructure.dart';


class AuthRepositoryImpl extends AuthRepository {

  final AuthDatasource dataSource;

  AuthRepositoryImpl({
    AuthDatasource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<UserAuth> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<UserAuth> login(String email, String password, UserType userType) {
    return dataSource.login(email, password, userType);
  }

  @override
  Future<UserAuth> register(Map<String,dynamic> user) {
    return dataSource.register(user);
  }

}