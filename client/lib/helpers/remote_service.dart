import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/intake.dart';

// ! API IMPORTS
/*
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
*/

class RemoteService {
  static late List<Intake> cachedIntakes;
  static late SharedPreferences _prefs;
  static late Uuid _uuid;

  static Future<List<Intake>> fetchIntakes() async {
    final savedList = _prefs.getStringList('intake_list');
    cachedIntakes = savedList == null ? [] : Intake.parseStringList(savedList);
    return cachedIntakes;
  }

  static Future init() async {
    _uuid = const Uuid();
    _prefs = await SharedPreferences.getInstance();
    await fetchIntakes();
  }

  static Future<List<Intake>> getAllIntakes([refetch = false]) async {
    return refetch ? await fetchIntakes() : cachedIntakes;
  }

  static Future<bool> resetIntakes() async {
    bool success = await _prefs.remove('intake_list');
    if (success) cachedIntakes = [];
    return success;
  }

  static Future<bool> deleteIntake(Intake obj) async {
    return cachedIntakes.remove(obj) &&
        await _prefs.setStringList('intake_list', cachedIntakes.jsonify());
  }

  static Future<bool> createIntake(String name, int calories, int protein,
      int carbs, int fats, int sodium) async {
    final dt = DateTime.now();

    cachedIntakes.add(Intake(
      id: _uuid.v4(),
      name: name,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fats: fats,
      sodium: sodium,
      alreadyAte: true,
      loadDate: dt,
      editDate: dt
    ));

    return await _prefs.setStringList('intake_list', cachedIntakes.jsonify());
  }

  static Future<bool> editIntake(Intake data) async {
    data.editDate = DateTime.now();
    return await _prefs.setStringList('intake_list', cachedIntakes.jsonify());
  }

  static Future<bool> duplicateIntake(Intake data) async {
    return await createIntake(
      data.name, 
      data.calories, 
      data.protein, 
      data.carbs, 
      data.fats, 
      data.sodium
    );
  }

  // ! API version
  /*
  static late Map<String, String> _headers;
  static late String _scheme;
  static late String _host;
  static late int _port;

  static Future init() async {
    _scheme = dotenv.env['HTTPS']!.toLowerCase() == 'true' ? 'https' : 'http';
    _host = dotenv.env['API_URL']!;
    _port = int.parse(dotenv.env['PORT']!);

    _headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Device-Id": await _getDeviceId() ?? '-'
    };

    cachedIntakes = [];
  }

  static Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    return Platform.isIOS
      ? (await deviceInfo.iosInfo).identifierForVendor
      : (await deviceInfo.androidInfo).androidId;
  }

  static Uri _getRequestURI(String path) {
    return Uri(scheme: _scheme, host: _host, port: _port, path: path);
  }

  // TODO: Error handling
  static Future<List<Intake>> getAllIntakes() async {
    var res = await http.get(_getRequestURI('intake/get'), headers: _headers);

    if (res.statusCode == 200) {
      var answer = Response.fromJson(res.body);
      if (!answer.error) {
        cachedIntakes = Intake.parseList(answer.content);
      }
    }

    return cachedIntakes;
  }

  // TODO: Error handling
  static Future<bool> resetIntakes() async {
    var res =
        await http.delete(_getRequestURI('intake/delete'), headers: _headers);

    if (res.statusCode == 204) {
      cachedIntakes = [];
      return true;
    }

    return false;
  }

  // TODO: Error handling
  static Future<bool> deleteIntake(Intake obj) async {
    var res = await http.delete(_getRequestURI("intake/delete/${obj.id}"),
        headers: _headers);

    if (res.statusCode == 204) {
      return cachedIntakes.remove(obj);
    }

    return false;
  }

  // TODO: Error handling
  static Future<bool> createIntake(
    String name,
    int calories,
    int protein,
    int carbs,
    int fats,
    int sodium
  ) async {
    var res = await http.post(
      _getRequestURI("intake/create"),
      headers: _headers,
      body: jsonEncode({
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fats': fats,
        'sodium': sodium
      })
    );

    if (res.statusCode == 201) {
      var answer = Response.fromJson(res.body);
      if (!answer.error) {
        Intake newIntake = Intake.parse(answer.content);
        cachedIntakes.add(newIntake);
        return true;
      }
    }

    return false;
  }

  // TODO: Error handling & el método en si xd
  static Future<bool> duplicateIntake(Intake data) async {
    data.editDate = DateTime.now().toUtc();
    data.loadDate = DateTime.now().toUtc();
    
    var res = await http.post(
      _getRequestURI("intake/create"),
      headers: _headers,
      body: data.jsonify(true)
    );

    if (res.statusCode == 201) {
      var answer = Response.fromJson(res.body);
      if (!answer.error) {
        Intake newIntake = Intake.parse(answer.content);
        cachedIntakes.add(newIntake);
        return true;
      }
    }

    return false;
  }

  // TODO: Error handling
  static Future<bool> editIntake(Intake data) async {
    data.editDate = DateTime.now().toUtc();

    var res = await http.put(
      _getRequestURI("intake/edit/${data.id}"),
      headers: _headers,
      body: data.jsonify()
    );

    if (res.statusCode == 200) {
      var answer = Response.fromJson(res.body);
      if (!answer.error) {
        Intake newIntake = Intake.parse(answer.content);
        cachedIntakes.remove(data);
        cachedIntakes.add(newIntake);
        return true;
      }
    }

    return false;
  }
  */
}
