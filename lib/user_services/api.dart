import 'package:flutter/material.dart';
import 'package:flutterapps/user_services/interceptors.dart';
import 'package:flutterapps/user_services/storage.dart';
import 'package:dio/dio.dart';


class API {
  late final Dio _dio;
  final secureStorage = SecureStorageService();
  Map<String, dynamic> monthlyBills = {};

  API() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  Future getMonthlyBills(BuildContext context) async {
    const url = 'http://10.10.110.74:8005/rest/v1/mensual_bills/get_last_bills_by_customer/4614/';

    final response = await _dio.get(url);
    if(response.statusCode == 200) {
      monthlyBills =  response.data;
    } else {
      print('Error');
    }
  }



}