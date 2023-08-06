import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String keyMovieDB = dotenv.env['KEY_MOVIEDB'] ?? 'La key no es válida';
  
}