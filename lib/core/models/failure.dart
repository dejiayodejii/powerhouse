class Failure {
  final String _message;
  final StackTrace? stackTrace;
  Failure({
    String? message,
    this.stackTrace,
  }) : _message = message ?? "Something went wrong";

  String get message => _message;

  @override
  String toString() => _message;
  String toDebugString() =>
      'Failure(message: $_message, stackTrace: $stackTrace)';
}
