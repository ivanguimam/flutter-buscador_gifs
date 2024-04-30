import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> search(String query, int page) async {
  int limit = 25;
  int offset = page == 1 ? 0 : page * limit;
  Uri uri = Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=oasc03L5af5rq5m93ZFcrtszkUdDS11J&q=${query}&limit=${limit}&offset=${offset}&rating=g&lang=en&bundle=messaging_non_clips');
  http.Response response = await http.get(uri);

  return json.decode(response.body);
}

Future<Map> fetch_trending(int page) async {
  int limit = 25;
  int offset = page == 1 ? 0 : page * limit;

  Uri uri = Uri.parse('https://api.giphy.com/v1/gifs/trending?api_key=oasc03L5af5rq5m93ZFcrtszkUdDS11J&limit=${limit}&offset=${offset}&rating=g&bundle=messaging_non_clips');
  http.Response response = await http.get(uri);

  return json.decode(response.body);
}