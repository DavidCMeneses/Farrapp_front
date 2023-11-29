import 'package:farrap/domain/entities/establishment.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service.dart';
import 'package:farrap/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:farrap/presentation/providers/business_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final establishmentProvider = StateNotifierProvider<EstablishmentMapNotifier, Map<String, Establishment>>((ref) {
  final businessRepository = ref.watch( businessRepositoryProvider );
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return EstablishmentMapNotifier(
    getEstablishment: businessRepository.getEstablishmentFromId,
    saveRatingCallback: businessRepository.saveRating,
    keyValueStorageService: keyValueStorageService
    );
});


typedef GetEstablishmentCallback = Future<Establishment>Function(String token, String establishmentId);
typedef SaveRatingCallback = Future<bool>Function(String token, String establishmentId, int rating);

class EstablishmentMapNotifier extends StateNotifier<Map<String,Establishment>> {

  final GetEstablishmentCallback getEstablishment;
  final SaveRatingCallback saveRatingCallback;
  final KeyValueStorageService keyValueStorageService;

  EstablishmentMapNotifier({
    required this.getEstablishment,
    required this.saveRatingCallback,
    required this.keyValueStorageService
  }): super({});


  Future<void> loadEstablishment( String establishmentId ) async {
    if ( state[establishmentId] != null ) return;

    final token = await keyValueStorageService.getValue<String>('token');

    final establishment = await getEstablishment( token??"d", establishmentId );
    state = { ...state, establishmentId: establishment };
  }

  Future<void> saveRating( String establishmentId, int rating ) async {
    final token = await keyValueStorageService.getValue<String>('token');
    final saveOk = await saveRatingCallback( token??"ds", establishmentId, rating);
    print(saveOk);
  }

  Future<void> refreshEstablishment( String establishmentId ) async {
    state.remove(establishmentId);
    loadEstablishment(establishmentId);
  }

}