// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomException implements Exception {
  final String message;
  final String? stacktrace;
  CustomException({
    required this.message,
    this.stacktrace,
  });

  @override
  String toString() {
    var text = 'Message: $message | stacktrace: $stacktrace';
    return text;
  }
}
