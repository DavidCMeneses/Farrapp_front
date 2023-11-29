import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/providers/establishment_provider.dart';
import 'package:farrap/presentation/widgets/custom_checkbox.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



//! 3 - StateNotifierProvider - consume afuera
final filterProvider = StateNotifierProvider.autoDispose<FilterNotifier,FilterState>((ref) {

  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;


  return FilterNotifier(
    loginUserCallback:loginUserCallback
  );
});


//! 2 - Como implementamos un notifier
class FilterNotifier extends StateNotifier<FilterState> {

  final Function(String, String, UserType) loginUserCallback;

  FilterNotifier({
    required this.loginUserCallback,
  }): super( FilterState() );
  
  onFlagChange( bool value ) {
    state = state.copyWith(
      flag: value,
      );
  }

  onSortedChange( Filter? value ) {
    state = state.copyWith(
      sortType: value,
    );
  }

  onFilterMusicChange( List<String> value ) {
    state = state.copyWith(
      filterMusic: value,
    );
  }

  onFilterEstablishmentChange( List<String> value ) {
    state = state.copyWith(
      filterEstablishment: value,
    );
  }

  String onFormSubmit() {
    final filterMusic = state.filterMusic.join("|");
    final filterEstablishment = state.filterEstablishment.join("|");
    final filters = "$filterMusic-$filterEstablishment-${state.sortType.name}-${state.flag}";

    return filters;

  }

}


//! 1 - State del provider
class FilterState {

  List<String> filterMusic;
  List<String> filterEstablishment;
  bool flag;
  Filter sortType;

  FilterState({
    this.flag = false,
    this.filterMusic = const [],
    this.filterEstablishment = const [],
    this.sortType = Filter.asc
  });

  FilterState copyWith({
    bool? flag,
    List<String>? filterMusic,
    List<String>? filterEstablishment,
    Filter? sortType,

  }) => FilterState(
    flag: flag ?? this.flag,
    filterMusic: filterMusic ?? this.filterMusic,
    filterEstablishment: filterEstablishment ?? this.filterEstablishment,
    sortType: sortType ?? this.sortType,

  );

}
