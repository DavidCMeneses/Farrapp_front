

import 'package:farrap/presentation/screens/Auth/initial_loading_screen.dart';
import 'package:farrap/presentation/screens/Auth/login_screen.dart';
import 'package:farrap/presentation/screens/Home/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen()),
    GoRoute(
    path: '/initial_loading',
    builder: (context, state) => const InitialLoadingScreen()),
    GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen())
  
  ]
  );