class ForgotPasswordResponse {
  final String message;
  final String code;
  final String status;

  ForgotPasswordResponse({required this.message, required this.code, required this.status});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
    );
  }
}
