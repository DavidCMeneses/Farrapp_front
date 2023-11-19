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

typedef EstablishmentCallBack = Future<EstablishmentResult> Function(
    String token, int page);

class HomeNotifier extends StateNotifier<EstablishmentResult> {
  int currentPage = 0;
  bool isLoading = false;
  EstablishmentCallBack fetchMoreEstablishments;
  KeyValueStorageService keyValueStorageService;

  HomeNotifier({
    required this.fetchMoreEstablishments,
    required this.keyValueStorageService,
  }) : super(EstablishmentResult(totalPages: 1, establishments: []));

  Future<void> loadNextPage() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (isLoading) return;
    isLoading = true;

    currentPage++;
    if (currentPage > state.totalPages) return;

    final EstablishmentResult establishmentsResult =
        await fetchMoreEstablishments(token ?? '', currentPage);

    state = state.copyWith(
        totalpages: establishmentsResult.totalPages,
        establishments: [
          ...state.establishments,
          ...establishmentsResult.establishments
        ]);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
