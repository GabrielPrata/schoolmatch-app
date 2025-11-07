
import 'package:http/http.dart' as http;
import 'package:school_match/util/constants.dart';

class UserService {
  static Future<http.Response> requestUserData(String userId) async {
    final url = Uri.parse('${Constants.LGPD}/$userId');
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> deleteUserData(String userId) async {
    final url = Uri.parse('${Constants.LGPD}/$userId');
    final response = await http.delete(url);
    return response;
  }
}
