import 'dart:convert';
import 'dart:io';

class OllamaService {
  final Uri endpoint;
  final String model;

  const OllamaService({
    required this.endpoint,
    this.model = 'llama3.2',
  });

  Future<String> summarize({
    required String prompt,
    Duration timeout = const Duration(seconds: 20),
  }) async {
    final client = HttpClient()..connectionTimeout = timeout;
    try {
      final request = await client.postUrl(endpoint);
      request.headers.contentType = ContentType.json;
      request.write(
        jsonEncode({
          'model': model,
          'prompt': prompt,
          'stream': false,
        }),
      );
      final response = await request.close().timeout(timeout);
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException('Ollama returned ${response.statusCode}: $body');
      }
      final data = jsonDecode(body) as Map<String, dynamic>;
      return data['response'] as String? ?? '';
    } finally {
      client.close(force: true);
    }
  }
}
