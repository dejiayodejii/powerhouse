// class PasswordResetState {
//   bool showPasword;
//   bool showVisibilityIcon;
//   PasswordResetState({
//     this.showVisibilityIcon = false,
//     this.showPasword = false,
//   });
//   PasswordResetState copyWith({
//     bool? showPasword,
//     bool? showVisibilityIcon,
//   }) {
//     return PasswordResetState(
//       showPasword: showPasword ?? this.showPasword,
//       showVisibilityIcon: showVisibilityIcon ?? this.showVisibilityIcon,
//     );
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:powerhouse/core/models/_models.dart';

abstract class PasswordResetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PasswordResetInitialState extends PasswordResetState {}

class PasswordResetLoadingState extends PasswordResetState {}

class PasswordResetSuccessState extends PasswordResetState {}

class PasswordResetFailureState extends PasswordResetState {
  final Failure failure;

  PasswordResetFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}
