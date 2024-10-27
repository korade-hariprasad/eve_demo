// helpers/api_helper.dart
import 'dart:convert';
import 'package:eve_demo/charger_list/model/charger_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHelper {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  // Method to fetch charging stations data
  Future<List<ChargerModel>> fetchChargeStations() async {
    final endpoint = '$baseUrl/chargers';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      //print(data);
      return data.map((json) => ChargerModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}