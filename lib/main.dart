import 'package:farrap/config/constants/environment.dart';
import 'package:farrap/config/router/app_router.dart';
import 'package:farrap/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {

  await Environment.initEnvironment();

  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appTheme = ref.watch( themeNotifierProvider );
    final appRouter = ref.watch( goRouterProvider );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routerConfig: appRouter,
      theme: appTheme.getTheme(),
    );
  }
}