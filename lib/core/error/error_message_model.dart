import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int statusCode;
  final String statusMessage;
  final bool success;
  const ErrorMessageModel({
    required this.statusCode,
    required this.success,
    required this.statusMessage,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      ErrorMessageModel(
        statusCode: json['status_code'],
        success: json['success'],
        statusMessage: json['status_message'],
      );
  @override
  List<Object?> get props => [success, statusCode, statusMessage];
}