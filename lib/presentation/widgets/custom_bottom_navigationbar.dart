import 'package:farrap/domain/entities/establishment_card.dart';
import 'package:farrap/presentation/delegates/search_movie_delegate.dart';
import 'package:farrap/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends ConsumerWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index, WidgetRef ref) {
    
    switch (index) {
      case 0:
        context.go('/');
        break;

      case 1:
        final searchedMovies = ref.read( searchedEstablishmentsProvider );
                final searchQuery = ref.read(searchQueryProvider);
                
                showSearch<EstablishmentCard?>(
                  query: searchQuery,
                  context: context, 
                  delegate: SearchEstablishmentDelegate(
                    initialEstablishments: searchedMovies,
                    searchEstablishments: ref.read( searchedEstablishmentsProvider.notifier ).searchEstablishmentsByQuery
                  )
                ).then((movie) {
                  if ( movie == null ) return;

                  context.push('/establishment/${ movie.id }');
                });
        break;

      case 2:
        context.go('/client_profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value, ref),
        elevation: 0,
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max), 
            label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), 
            label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box), 
            label: 'Cuenta'),
        ]
      );
  }
}
