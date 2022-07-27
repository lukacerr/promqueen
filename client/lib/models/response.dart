import 'dart:convert';

class Response {
  bool error;
  dynamic content;

  Response({
    this.error = false,
    this.content,
  });

  static Response fromJson(String str) {
    var data = json.decode(str) as Map<String, dynamic>;
    return Response(
      error: data["error"],
      content: data["content"],
    );
  }
}
