import 'package:farrap/domain/entities/establishment_result.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:farrap/presentation/providers/business_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider =
    StateNotifierProvider<HomeNotifier, EstablishmentResult>((ref) {
  final fetchMoreEstablishments =
      ref.watch(businessRepositoryProvider).getEstablishmentResultSearch;

  final keyValueStorageService = KeyValueStorageServiceImpl();

  return HomeNotifier(
      fetchMoreEstablishments: fetchMoreEstablishments,
      keyValueStorageService: keyValueStorageService);
});

typedef EstablishmentCallBack = Future<EstablishmentResult> Function(String token, 
                                                          String query, 
                                                          String musicFilter, 
                                                          String establishmentFilter,
                                                          String sortedBy,
                                                          String flag, 
                                                          int page);

class HomeNotifier extends StateNotifier<EstablishmentResult> {
  int currentPage = 0;
  bool isLoading = false;
  EstablishmentCallBack fetchMoreEstablishments;
  KeyValueStorageService keyValueStorageService;

  HomeNotifier({
    required this.fetchMoreEstablishments,
    required this.keyValueStorageService,
  }) : super(EstablishmentResult(totalPages: 1, establishments: []));

  Future<void> applyFilters(String? query) async {
    currentPage = 0;
    state = EstablishmentResult(totalPages: 1, establishments: []);
    await loadNextPage(query);
  }

  Future<void> loadNextPage(String? query) async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (isLoading) return;
    isLoading = true;

    currentPage++;
    if (currentPage > state.totalPages) {
      isLoading = false;
      return;};

    EstablishmentResult establishmentsResult;
    

    try {
      if (query != null){
        final filters = query.split("-");
        establishmentsResult = await fetchMoreEstablishments(
          token ?? '', 
          '', 
          filters[0], 
          filters[1], 
          filters[2], filters[3], currentPage);

      }else {
        establishmentsResult = await fetchMoreEstablishments(token ?? '', '', '', '', 'asc', "true", currentPage);

      }
      
    } catch (e) {
      isLoading = false;
      return;
    }

    state = state.copyWith(
        totalpages: 1,
        establishments: [
          ...state.establishments,
          ...establishmentsResult.establishments
        ]);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
