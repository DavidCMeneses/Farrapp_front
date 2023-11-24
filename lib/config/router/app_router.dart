

import 'package:farrap/config/router/app_router_notifier.dart';
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/screens/Auth/establishment_register_client_screen.dart';
import 'package:farrap/presentation/screens/Auth/pre_register_screen.dart';
import 'package:farrap/presentation/screens/Auth/register_client_screen.dart';
import 'package:farrap/presentation/screens/Auth/initial_loading_screen.dart';
import 'package:farrap/presentation/screens/Auth/login_screen.dart';
import 'package:farrap/presentation/screens/Home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



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
      path: '/clientRegister',
      builder: (context, state) => const ClientRegisterScreen()),
      GoRoute(
      path: '/establishmentRegister',
      builder: (context, state) => const EstablishmentRegisterScreen()),
      GoRoute(
      path: '/preRegister',
      builder: (context, state) => const PreRegisterScreen()),
    ],

    redirect: (context, state) {
      
      final isGoingTo = state.matchedLocation ;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/initial_loading' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/clientRegister' || isGoingTo == '/establishmentRegister'|| isGoingTo == '/preRegister' || isGoingTo == '/initial_loading' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/preRegister' || isGoingTo == '/clientRegister' || isGoingTo == '/establishmentRegister' ){
           return '/';
        }
      }


      return null;
    },
    );
});