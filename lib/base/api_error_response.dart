class ApiErrorResponse {
  dynamic error;
  bool? status;
  List<String>? messages;
  String? message;

  ApiErrorResponse({this.error, this.messages, this.status, this.message});

  ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] != null) {
      if (json['error'] is String) {
        error = json['error'] as String;
      } else if (json['error'] is bool) {
        error = json['error'] as bool;
      } else {
        error = json['error'];
      }
    }

    status = json['status'] is bool ? json['status'] as bool : null;

    if (json['messages'] != null && json['messages'] is List) {
      messages = (json['messages'] as List).cast<String>();
    } else if (json['errors'] != null && json['errors'] is Map) {
      final Map<String, dynamic> errorsMap = json['errors'];
      messages = errorsMap.values
          .expand((value) => value as List)
          .map((e) => e.toString())
          .toList();
    }

    if (json['message'] != null && json['message'] is String) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['status'] = status;
    data['messages'] = messages;
    data['message'] = message;
    return data;
  }
}
