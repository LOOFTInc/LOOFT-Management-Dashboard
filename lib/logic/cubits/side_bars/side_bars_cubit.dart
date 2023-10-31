import 'package:bloc/bloc.dart';
import 'package:management_dashboard/data/models/enums/side_bar_states.dart';

part 'side_bars_state.dart';

class SideBarsCubit extends Cubit<SideBarsState> {
  /// Side Bars Cubit
  SideBarsCubit() : super(SideBarsState());

  /// Hides the left bar
  void hideLeftBar() {
    emit(state.copyWith(leftBarState: SideBarStates.closed));
  }

  /// Shows the left bar
  void showLeftBar() {
    emit(state.copyWith(leftBarState: SideBarStates.open));
  }

  /// Hides the right bar
  void hideRightBar() {
    emit(state.copyWith(rightBarState: SideBarStates.closed));
  }

  /// Shows the right bar
  void showRightBar() {
    emit(state.copyWith(rightBarState: SideBarStates.open));
  }

  /// Collapses the left bar
  void collapseLeftBar() {
    emit(state.copyWith(leftBarState: SideBarStates.collapsed));
  }

  /// Toggles the left bar between open, collapsed and closed
  void toggleDesktopLeftBar() {
    if (state.leftBarState == SideBarStates.open) {
      collapseLeftBar();
    } else {
      showLeftBar();
    }
  }

  /// Toggles the left bar between collapsed and closed
  void toggleLeftBarForTablet() {
    if (state.leftBarState == SideBarStates.collapsed) {
      hideLeftBar();
    } else {
      collapseLeftBar();
    }
  }

  /// Toggles the left bar between collapsed and closed
  void toggleLeftBarForMobile() {
    if (state.leftBarState == SideBarStates.open) {
      hideLeftBar();
    } else {
      showLeftBar();
    }
  }

  /// Toggles the right bar
  void toggleRightBar() {
    if (state.rightBarState == SideBarStates.open) {
      hideRightBar();
    } else {
      showRightBar();
    }
  }
}
