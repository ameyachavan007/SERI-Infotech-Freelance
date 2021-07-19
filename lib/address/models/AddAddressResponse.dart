import 'package:dio/dio.dart';

class AddAddressResponseData {
  final bool status;
  final String message;

  AddAddressResponseData({this.status, this.message});

  factory AddAddressResponseData.getAddAddressResponseFromHttpResponse(
      Response<dynamic> response) {
    return AddAddressResponseData(
      status: response.data['status'],
      message: response.data['msg'],
    );
  }
}
