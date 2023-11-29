
import 'package:farrap/config/router/app_router_notifier.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/screens/Auth/establishment_register_client_screen.dart';
import 'package:farrap/presentation/screens/Auth/pre_register_screen.dart';
import 'package:farrap/presentation/screens/Auth/register_client_screen.dart';
import 'package:farrap/presentation/screens/Auth/initial_loading_screen.dart';
import 'package:farrap/presentation/screens/Auth/login_screen.dart';
import 'package:farrap/presentation/screens/Home/establishment_screen.dart';
import 'package:farrap/presentation/screens/Home/home_screen.dart';
import 'package:farrap/presentation/screens/Home/profile_screen.dart';
import 'package:farrap/presentation/screens/Home/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final keyValueStorageServiceImpl = KeyValueStorageServiceImpl();
final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/initial_loading',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen()),
      GoRoute(
      path: '/initial_loading',
      builder: (context, state) => const InitialLoadingScreen()),
      GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen()),
      GoRoute(
      path: '/establishment_register',
      builder: (context, state) => const EstablishmentRegisterScreen()),
      GoRoute(
      path: '/client_register',
      builder: (context, state) => const ClientRegisterScreen()),
      GoRoute(
      path: '/establishment/:id',
      builder: (context, state) {
            final establishmentId = state.pathParameters['id'] ?? '1';

            return EstablishmentScreen( establishmentId: establishmentId );
          },),
      GoRoute(
      path: '/pre_register',
      builder: (context, state) => const PreRegisterScreen()),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen()),
    
    ],

    redirect: (context, state) async {
      
      final isGoingTo = state.matchedLocation ;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/initial_loading' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/client_register' || isGoingTo == '/establishment_register'|| isGoingTo == '/pre_register' || isGoingTo == '/initial_loading' ) return null;

        return '/login';
      }


      if ( authStatus == AuthStatus.authenticated ) {
        if(isGoingTo == '/establishment_register') {
          return '/';
        }
        if ( isGoingTo == '/login' || isGoingTo == '/register' ){
          
          final userType = await keyValueStorageServiceImpl.getValue<String>("user_type");
          if (userType == "establishment"){
            final userId = await keyValueStorageServiceImpl.getValue<int>("id");
            return '/establishment/$userId';
          } 
          return '/';
        }
      }



      return null;
    },
    );
});