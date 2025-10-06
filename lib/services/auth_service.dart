import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const base = 'http://10.0.2.2:3000/api'; // se emulador Android: 10.0.2.2
  // atenção: em dispositivo físico usar IP da sua máquina: ex: http://192.168.0.10:3000

  static Future<bool> login(String user, String pass) async {
    final res = await http.post(Uri.parse('$base/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'user': user, 'password': pass}),
    );
    if (res.statusCode == 200) {
      final j = jsonDecode(res.body);
      // TODO: savlar token com flutter secure storage ou shared_preferences
      return true;
    }
    return false;
  }

  static Future<bool> register(String user, String email, String pass, String birth) async {
    final res = await http.post(Uri.parse('$base/auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode ({'username': user, 'email': email, 'password': pass, 'bith': birth}),
    );
    return res.statusCode == 201;
  }
}