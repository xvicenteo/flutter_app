import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapps/user_services/storage.dart';

import 'package:flutterapps/pages/home.dart';

class AuthController {

  final secureStorage = SecureStorageService();

  Future loginUser(BuildContext context, String username, String password) async {
    const url = 'http://10.10.110.74:8005/rest/v1/token/';

    final response = await http.post(Uri.parse(url), body: {
      "username": username,
      "password": password
    });

    if(response.statusCode == 200) {
      var loginArr = jsonDecode(response.body);
      await secureStorage.writeToken('token', loginArr['access']);
      await secureStorage.writeToken('refresh', loginArr['refresh']);

      if(!context.mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(token: secureStorage.readToken('refresh'))));

    } else {
      print('error login');
    }
  }

  Future refreshToken (String refreshToken) async{

    const String refreshUrl = "http://10.10.110.74:8005/rest/v1/token/refresh/";
    var refreshToken = await secureStorage.readToken('refresh');

    final response = await http.post(Uri.parse(refreshUrl), body: {
      "refresh": refreshToken
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to refresh access token');
    }

  }

  void performTokenRefresh(String refreshToken) async {
    try {
      final refreshResponse = await AuthController().refreshToken(refreshToken);

      // Handle the refresh token response containing the new access token
      final newAccessToken = refreshResponse['access'];

      // Update the stored access token with the new one in Flutter's storage mechanism
      await secureStorage.writeToken('token', newAccessToken);

    } catch (e) {
      print('Token refresh failed: $e');
    }
  }
}

