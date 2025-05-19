import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_match/util/constants.dart';

class AppDataService {
  static Future<String> getAppCourses() async {
    final http.Response response = await http.get(
      Uri.parse(Constants.getAllCourses),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('${Constants.basicAuthUser}:${Constants.basicAuthPass}'))}',
      },
    );
    print('Response status, ${response.statusCode}');
    print('Response body, ${response.body}');
    return response.body;
  }

  static Future<String> getCourseDuration(int courseId) async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.getCourseDuration}/$courseId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('${Constants.basicAuthUser}:${Constants.basicAuthPass}'))}',
      },
    );
    print('Response status, ${response.statusCode}');
    print('Response body, ${response.body}');
    return response.body;
  }

  static Future<String> getMainBlocks() async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.getMainBlocks}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('${Constants.basicAuthUser}:${Constants.basicAuthPass}'))}',
      },
    );
    print('Response status, ${response.statusCode}');
    print('Response body, ${response.body}');
    return response.body;
  }

   static Future<String> getSecondaryBlocks() async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.getSecondaryBlocks}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('${Constants.basicAuthUser}:${Constants.basicAuthPass}'))}',
      },
    );
    print('Response status, ${response.statusCode}');
    print('Response body, ${response.body}');
    return response.body;
  }


}
