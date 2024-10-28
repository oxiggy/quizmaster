import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiUrl = dotenv.env['API_URL']  ?? '';
final String apiKey = dotenv.env['API_KEY']  ?? '';