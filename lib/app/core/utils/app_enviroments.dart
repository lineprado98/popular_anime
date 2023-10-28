import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppEnviroments {
  static final baseUrl = dotenv.env['BASE_URL'] ?? '';
}
