class CustomException implements Exception {
  String message;
  CustomException(this.message);

  @override
  String toString() => message; // Personaliza a saída para ser apenas a mensagem
}