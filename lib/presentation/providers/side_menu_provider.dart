import 'package:farrap/presentation/screens/Home/edit_profile_screen.dart';
import 'package:farrap/presentation/screens/Home/log_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sideMenuProvider = StateNotifierProvider.autoDispose<SideMenuNotifier,SideMenuState>((ref) => SideMenuNotifier());

class SideMenuNotifier extends StateNotifier<SideMenuState>{

SideMenuNotifier():super(SideMenuState());

onPageChanged(int pageIndex){
  state = state.copyWith(
    pageIndex: pageIndex,
  );
  setCurrentPage();
  print(state.currentPageIndex);
}

 setCurrentPage(){
  switch(state.currentPageIndex){
    case 0:
    state.copyWith( 
      currentPage : const EditProfileScreen(),
    );
    break;
    default:
    return const LogOutScreen();
  }
}

  getCurrentPage(){
    return state.currentPage;
  }
}

class SideMenuState {

  final int currentPageIndex;
  final Widget currentPage;

  SideMenuState({
    this.currentPageIndex = 0,
    this.currentPage = const EditProfileScreen()
    });

  SideMenuState copyWith({
    int? pageIndex,
    Widget? currentPage,
  }) =>
      SideMenuState(
        currentPageIndex: pageIndex ?? currentPageIndex,
         currentPage: currentPage ?? this.currentPage,
      );


}
