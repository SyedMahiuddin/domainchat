import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:domainchat/app/consts/app_conts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/domain_model.dart';
import '../models/message_model.dart';

class ApiService{
  static Future<List<DomainModel>> fetchDomains() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.domainUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['hydra:member'] != null) {
          return List<DomainModel>.from(
            data['hydra:member'].map((item) => DomainModel.fromJson(item)),
          );
        } else {
          throw Exception('Failed to load domains');
        }
      } else {
        throw Exception('Failed to load domains');
      }
    } catch (e) {
      throw Exception('Error fetching domains: $e');
    }
  }

  static Future<bool> createAccount(String email, String password) async {
    final url = Uri.parse('${AppConstants.baseUrl}/accounts');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'address': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        log('Error creating account: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error: $e');
      return false;
    }
  }


  static Future<bool> login(String email, String password) async {
    final Uri url = Uri.parse('${AppConstants.baseUrl}/token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'address': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String id = data['id'];
        final String token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', id);
        await prefs.setString('user_token', token);

        log('Login successful. ID: $id, Token: $token');
        return true;
      } else {
        return false;}
    } catch (e) {

      log('Error: $e');
      throw Exception('Login failed');

    }
  }

  static Future<List<Message>> fetchMessages(int page) async {
    final Uri url = Uri.parse('${AppConstants.baseUrl}/messages?page=$page');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> messagesJson = data['hydra:member'];
        return messagesJson.map((json) => Message.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch messages. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch messages');
    }
  }
}