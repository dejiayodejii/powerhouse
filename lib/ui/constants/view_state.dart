import 'package:equatable/equatable.dart';
import 'package:powerhouse/core/enums/app_state.dart';
import 'package:powerhouse/core/models/_models.dart';

class ViewState<T> {
  final T? data;
  final AppState state;
  final Failure? error;

  ViewState._({this.data, required this.state, this.error});

  ViewState.loading()
      : this._(data: null, state: AppState.loading, error: null);

  ViewState.error(Failure error)
      : this._(data: null, state: AppState.error, error: error);

  ViewState.idle([T? data])
      : this._(data: data ?? data, state: AppState.idle, error: null);

  bool get isBusy => state == AppState.loading;
  bool get hasError => state == AppState.error;

  ViewState<T> copyWith({
    T? data,
    AppState? state,
    Failure? error,
  }) {
    return ViewState<T>._(
      data: data ?? this.data,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }

  ViewState<T> loading() {
    return copyWith(state: AppState.loading, error: null);
  }

  // HP
  // Windows 10
  // ROM 232
  // RAM 2
  // Amdei 2100 with hd graphic
  // 64 Bit
  // Hp 266 G3

  ViewState<T> idle([T? data]) {
    return copyWith(
      data: data,
      state: AppState.idle,
      error: null,
    );
  }

  ViewState<T> failure(Failure error) {
    return copyWith(
      state: AppState.error,
      error: error,
    );
  }

  void updateUser() {}

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ViewState<T> &&
        other.data == data &&
        other.state == state &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ state.hashCode ^ error.hashCode;
}

class ViewState2 extends Equatable {
  final AppState state;
  final Failure? error;

  const ViewState2({
    required this.state,
    this.error,
  });

  bool get isBusy => state == AppState.loading;
  bool get hasError => state == AppState.error;

  ViewState2 _copyWith({
    AppState? state,
    Failure? error,
  }) {
    return ViewState2(
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }

  ViewState2 idle() {
    return _copyWith(state: AppState.idle, error: null);
  }

  ViewState2 loading() {
    return _copyWith(state: AppState.loading, error: null);
  }

  ViewState2 failure(Failure error) {
    return _copyWith(state: AppState.error, error: error);
  }

  @override
  List<Object?> get props => [state, error];
}
