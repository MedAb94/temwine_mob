class RegisterAdapterError implements Exception {
  final String _message;

  RegisterAdapterError(String message)
      : _message = message,
        super();

  @override
  String toString() => _message;
}
