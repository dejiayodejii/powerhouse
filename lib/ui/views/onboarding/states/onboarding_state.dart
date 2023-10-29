import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final bool showPasword;
  final bool showVisibilityIcon;
  final int pageIndex;

  const OnboardingState({
    this.showVisibilityIcon = false,
    this.showPasword = false,
    this.pageIndex = 0,
  });

  OnboardingState copyWith({
    bool? showPasword,
    bool? showVisibilityIcon,
    int? pageIndex,
  }) {
    return OnboardingState(
      showPasword: showPasword ?? this.showPasword,
      showVisibilityIcon: showVisibilityIcon ?? this.showVisibilityIcon,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object?> get props => [showPasword, showVisibilityIcon, pageIndex];
}
