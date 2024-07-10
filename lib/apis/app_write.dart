import 'dart:developer';
import 'package:ai_assistant/helper/global.dart';
import 'package:appwrite/appwrite.dart';

class AppWrite {
  static final _client = Client();
  static final _database = Databases(_client);

  static void init() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('Your project id')
        .setSelfSigned(status: true); // For self-signed certificates, only use for development
    getApiKey();
  }

  static Future<void> getApiKey() async {
    try {
      final d = await _database.getDocument(
          databaseId: 'your database id',
          collectionId: 'your collection id',
          documentId: 'your document id'
      );

      // Assuming the API key is stored in a field named 'apiKey'
      GapiKey = d.data['apiKey'];
      log('Fetched API Key: $GapiKey');
    } catch (e) {
      log('Error fetching API key: $e');
    }
  }
}
