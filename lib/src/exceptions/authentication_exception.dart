import 'dart:convert';

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}

class ApiError {
  final String? errorKey;
  final List<dynamic>? details;

  ApiError({this.errorKey, this.details});

  Map<String, dynamic> toMap() {
    return {
      'key': errorKey,
      'details': details,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      errorKey: map['errorKey'],
      details:
          map.containsKey(map['errorKey']) ? map[map['errorKey']].toList() : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source));

  @override
  String toString() {
    return "($errorKey, ${details!.join(', ')})";
  }
}

class ApiException implements Exception {
  final List<ApiError>? apiErrors;
  final String message;

  ApiException({this.message = 'ApiError', this.apiErrors});
}
