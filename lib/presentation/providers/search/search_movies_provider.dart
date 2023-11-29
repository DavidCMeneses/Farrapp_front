import 'package:farrap/domain/entities/establishment_card.dart';
import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:farrap/presentation/providers/business_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedEstablishmentsProvider = StateNotifierProvider<SearchedEstablishmentsNotifier, List<EstablishmentCard>>((ref) {

  final businessRepository = ref.read( businessRepositoryProvider );
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return SearchedEstablishmentsNotifier(
    keyValueStorageService: keyValueStorageService,
    searchEstablishments: businessRepository.getEstablishmentResultSearch, 
    ref: ref
  );
});


typedef SearchEstablishmentsCallback = Future<EstablishmentResult> Function(String token, 
                                                                            String query, 
                                                                            String musicFilter, 
                                                                            String establishmentFilter,
                                                                            String sortedBy,
                                                                            bool flag, 
                                                                            int page);

class SearchedEstablishmentsNotifier extends StateNotifier<List<EstablishmentCard>> {
  final KeyValueStorageService keyValueStorageService;
  final SearchEstablishmentsCallback searchEstablishments;
  final Ref ref;

  SearchedEstablishmentsNotifier({
    required this.keyValueStorageService,
    required this.searchEstablishments,
    required this.ref,
  }): super([]);


  Future<List<EstablishmentCard>> searchEstablishmentsByQuery( String query ) async{
    final token = await keyValueStorageService.getValue<String>('token');
    final EstablishmentResult resultEstablishment = await searchEstablishments(token ?? '', query, '', '', 'asc', false, 1);
    final List<EstablishmentCard> establishments = resultEstablishment.establishments;
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = establishments;
    return establishments;
  }

}






