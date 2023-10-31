part of 'side_bars_cubit.dart';

/// The state for the Side Bars observables cubit
class SideBarsState {
  /// Is the left bar open
  SideBarStates leftBarState;

  /// Is the right bar open
  SideBarStates rightBarState;

  /// Constructor
  SideBarsState({
    this.leftBarState = SideBarStates.open,
    this.rightBarState = SideBarStates.open,
  });

  /// Copy the current state with some changes
  SideBarsState copyWith({
    SideBarStates? leftBarState,
    SideBarStates? rightBarState,
  }) {
    return SideBarsState(
      leftBarState: leftBarState ?? this.leftBarState,
      rightBarState: rightBarState ?? this.rightBarState,
    );
  }
}
