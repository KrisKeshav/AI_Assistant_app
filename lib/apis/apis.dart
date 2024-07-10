import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ai_assistant/helper/global.dart';

class APIs {
  static const String gapiUrlChat = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';
  static String gapiToken = GapiKey;

  static Future<String> getAnswer(String question) async {
    try {
      final String url = '$gapiUrlChat?key=$gapiToken';

      final body = jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": question}
            ]
          }
        ]
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null && data['candidates'] != null && data['candidates'] is List && data['candidates'].isNotEmpty) {
          final parts = data['candidates'][0]['content']['parts'];
          if (parts != null && parts is List && parts.isNotEmpty) {
            return parts[0]['text'] ?? 'No generated text found';
          } else {
            return 'Invalid response structure';
          }
        } else {
          return 'Invalid response structure';
        }
      } else {
        return 'API call failed';
      }
    } catch (e) {
      return 'Something went wrong (Try again later)';
    }
  }

  static Future<List<String>> searchAiImages(String prompt) async {
    try {
      final res = await http.get(Uri.parse('https://lexica.art/api/v1/search?q=$prompt'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List.from(data['images']).map((e) => e['src'].toString()).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
