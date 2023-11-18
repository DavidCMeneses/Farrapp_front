import 'package:farrap/domain/entities/client_user.dart';
import 'package:farrap/domain/entities/establishment_user.dart';
import 'package:farrap/domain/entities/user_auth.dart';
import 'package:farrap/domain/repositories/auth_repository.dart';
import 'package:farrap/infraestructure/infrastructure.dart';
import 'package:farrap/infraestructure/models/preference_model.dart';
import 'package:farrap/infraestructure/models/schedule_model.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:farrap/presentation/widgets/gender_type.dart';
import 'package:farrap/presentation/widgets/gender_type.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();


  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});



class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super( AuthState() ) {
    checkAuthStatus();
  }
  

  Future<void> loginUser( String email, String password, UserType userType) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password, userType);
      user.userType = userType;
      user.userType = userType;
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout( e.message );
    } catch (e){
      logout( 'Error inesperado' );
    }

    // final user = await authRepository.login(email, password);
    // state =state.copyWith(user: user, authStatus: AuthStatus.authenticated)

  }

  void registerUser(String firstName, 
                    String lastName,
                    String username,
                    String password, 
                    String email, 
                    String birthDate, 
                    List<PreferenceModel> preferences,
                    UserType userType,
                    GenderType genderType) async {

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final newUser = ClientUser(firstName: firstName, lastName: lastName, username: username, email: email,password: password, birthDate: birthDate, preferences: preferences, userType: userType, genderType: genderType);
      final user = await authRepository.register(newUser, userType);
      user.userType = userType;
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout( e.message );
    } catch (e){
      logout( 'Error inesperado' );
    }
    
  }

  void establishmentRegisterUser(
                    String name, 
                    String email, 
                    String username,
                    String password, 
                    String address, 
                    String city, 
                    String description, 
                    String playlist,
                    String imgUrl,
                    String rut,
                    List<PreferenceModel> preferences,
                    List<ScheduleModel> schedules,
                    UserType userType) async {

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final newUser = EstablishmentUser(name: name, 
                                        email: email, 
                                        username: username,
                                        password: password, 
                                        address: address, 
                                        city: city, 
                                        description: description, 
                                        rut: rut, 
                                        preferences: preferences, 
                                        schedules: schedules, 
                                        playlist: playlist, 
                                        imgUrl: imgUrl, 
                                        userType: userType);
      final user = await authRepository.establishmentRegister(newUser, userType);
      user.userType = userType;
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout( e.message );
    } catch (e){
      logout( 'Error inesperado' );
    }
    
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    final userType = await keyValueStorageService.getValue<String>('user_type');
    final userType = await keyValueStorageService.getValue<String>('user_type');
    if( token == null ) return logout();
    if( userType == null ) return logout();
    if( userType == null ) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      user.userType = UserType.values.firstWhere((e) => e.toString() == userType);
      user.userType = UserType.values.firstWhere((e) => e.toString() == userType);
      _setLoggedUser(user);

    } catch (e) {
      logout();
    }

  }

  void _setLoggedUser( UserAuth user,  ) async {
    String nameType = user.userType?.name ?? "client";
    String nameType = user.userType?.name ?? "client";
    await keyValueStorageService.setKeyValue('token', user.token);
    await keyValueStorageService.setKeyValue('user_type', nameType);
    await keyValueStorageService.setKeyValue('user_type', nameType);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('user_type');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }

}



enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {

  final AuthStatus authStatus;
  final UserAuth? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    UserAuth? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );




}