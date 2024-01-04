import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:nonnative_lab/Domain/Saving.dart';

class SavingAPI{
  String baseURL = "http://10.0.2.2:8080/api/saving";
  final http.Client server = http.Client();

  Future<bool> isNetworkConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      log("Disconnected");
      return false;
    }
    log("Connected");
    return true;
  }

  Future<List<Saving>> getAllFromServer() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonExpenses = json.decode(response.body);
      List<Saving> savings =
      jsonExpenses.map((json) => Saving.fromJson(json)).toList();
      log("Successfully get all!");
      return savings;
    } else {
      log("Fail to get all!");
      throw Exception('Failed to load expenses');
    }
  }

  Future<Saving> addOnServer(Saving newExpense) async {
    final response = await server.post(
      Uri.parse(baseURL),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(newExpense.toJson()), // Convert the newExpense to JSON
    );

    if (response.statusCode == 201) {
      final dynamic jsonExpense = json.decode(response.body);
      log('Successfully ADDED on server : '+newExpense.name);
      return Saving.fromJson(jsonExpense);
    } else {
      log('Failed to ADD saving on server: '+newExpense.name);
      throw Exception('Failed to create saving on server');
    }
  }

  Future<Saving> updateSavingOnServer(Saving saving) async {
    final response = await server.put(
      Uri.parse('$baseURL'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json
          .encode(saving.toJson()), // Convert the updatedExpense to JSON
    );

    if (response.statusCode == 200) {
      final dynamic jsonExpense = json.decode(response.body);
      log('Successfully UPDATED on server : '+saving.name);
      return Saving.fromJson(jsonExpense);
    } else {
      throw Exception('Failed to UPDATE saving on server');
    }
  }

  Future<void> deleteSavingFromServer(int savingId) async {
    final response = await server.delete(
      Uri.parse('$baseURL/$savingId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      log('Successfully DELETED on server ');
    } else {
      throw Exception('Failed to delete saving on server');
    }
  }

  void closeServer() {
    server.close();
  }
}