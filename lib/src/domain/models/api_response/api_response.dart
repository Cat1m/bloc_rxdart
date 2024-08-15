// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_rxdart/src/utils/enum/enums.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(
    this.status,
    this.data,
    this.message,
  );

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}
