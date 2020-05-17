import 'dart:convert';
import 'package:http/http.dart' as http;

class User{
  String id;
  String first_name;
  String last_name;

  User({this.id, this.first_name, this.last_name});
  factory User.CreateUser(Map<String, dynamic> object)
  {
    return User(
        id: object['id'].toString(),
        first_name: object['first_name'],
        last_name: object['last_name']
    );
  }

  static Future<User> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users/" + id;
    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    var UserData = (jsonObject as Map<String, dynamic>)['data'];

    return User.CreateUser(UserData);
  }
}