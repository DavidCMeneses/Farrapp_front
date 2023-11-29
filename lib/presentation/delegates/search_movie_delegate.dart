import 'dart:async';


import 'package:farrap/domain/entities/establishment_card.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';


typedef SearchEstablishmentsCallback = Future<List<EstablishmentCard>> Function( String query );

class SearchEstablishmentDelegate extends SearchDelegate<EstablishmentCard?>{


  final SearchEstablishmentsCallback searchEstablishments;
  List<EstablishmentCard> initialEstablishments;
  
  StreamController<List<EstablishmentCard>> debouncedEstablishments = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();


  Timer? _debounceTimer;

  SearchEstablishmentDelegate({
    required this.searchEstablishments,
    required this.initialEstablishments,
  }):super(
    searchFieldLabel: 'Buscar establecimiento'
  );

  void clearStreams() {
    debouncedEstablishments.close();
  }

  void _onQueryChanged( String query ) {
    isLoadingStream.add(true);

    if ( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration( milliseconds: 500 ), () async {
      if ( query.isEmpty ) {
        debouncedEstablishments.add([]);
        isLoadingStream.add(false);
        return;
      }

      final establishments = await searchEstablishments( query );
      initialEstablishments = establishments;
      debouncedEstablishments.add(establishments);
      isLoadingStream.add(false);

    });

  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialEstablishments,
      stream: debouncedEstablishments.stream,
      builder: (context, snapshot) {
        
        final establishments = snapshot.data ?? [];

        return ListView.builder(
          itemCount: establishments.length,
          itemBuilder: (context, index) => _EstablishmentItem(
            establishment: establishments[index],
            onEstablishmentSelected: (context, establishment) {
              clearStreams();
              close(context, establishment);
            },
          ),
        );
      },
    );
  }


  // @override
  // String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [

      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
            if ( snapshot.data ?? false ) {
              return SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  child: IconButton(
                    onPressed: () => query = '', 
                    icon: const Icon( Icons.refresh_rounded )
                  ),
                );
            }

             return FadeIn(
                animate: query.isNotEmpty,
                child: IconButton(
                  onPressed: () => query = '', 
                  icon: const Icon( Icons.clear )
                ),
              );

        },
      ),
      
       
        



    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
          clearStreams();
          close(context, null);
        }, 
        icon: const Icon( Icons.arrow_back_ios_new_rounded)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);
    return buildResultsAndSuggestions();

  }

}

class _EstablishmentItem extends StatelessWidget {

  final EstablishmentCard establishment;
  final Function onEstablishmentSelected;

  const _EstablishmentItem({
    required this.establishment,
    required this.onEstablishmentSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onEstablishmentSelected(context, establishment);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
    
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network( 
                  establishment.imageUrl,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
    
            const SizedBox(width: 10),
            
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( establishment.name, style: textStyles.titleMedium ),
    
                  ( establishment.address.length > 100 )
                    ? Text( '${establishment.address.substring(0,100)}...' )
                    : Text( establishment.address ),
    
                  Row(
                    children: [
                      Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
                      const SizedBox(width: 5),
                      Text( 
                        "${establishment.rating}",
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900 ),
                      ),
                    ],
                  )
    
                  
                ],
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}