import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Article {
  static String baseUrl = "http://localhost:8000";

  static Future<List> getAllArticle() async {
    try {
      var res = await http.get(Uri.parse("$baseUrl/articles"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static Future<List> getArticle(int id) async {
    try {
      var res = await http.get(Uri.parse("$baseUrl/articles/$id"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static Login(BuildContext context, login, password) async {
    try {
      var connection = {"email": login, "password": password};
      var res =
          await http.post(Uri.parse("$baseUrl/Connexion"), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': login,
          'password': password
        }),);
      print("login : " + res.statusCode.toString() );
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static ajout(BuildContext context, String name, String prix,
      String image, String quantite) async {
    try {
      var res = await http.post(
        Uri.parse("$baseUrl/articles"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'prix': prix,
          'image': image,
          'quantite': quantite
        }),
      );
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Update(BuildContext context, int id, String name, String prix,
      String image, String quantite) async {
    try {
      var res = await http.put(
        Uri.parse("$baseUrl/articles/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'prix': prix,
          'image': image,
          'quantite': quantite,
          'id': id.toString()
        }),
      );
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Delete(BuildContext context, int id) async {
    var res = await http.delete(Uri.parse('$baseUrl/articles/$id'),
        body: id.toString());
    if (res.statusCode == 200) {
      Navigator.pushNamed(context, '/liste');
    } else {
      Navigator.pushNamed(context, '/');
    }
  }
}
