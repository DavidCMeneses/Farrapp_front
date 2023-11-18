import 'package:flutter_dotenv/flutter_dotenv.dart';


class Environment {

  static initEnvironment() async {
  
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
  static String cloudinaryCloudName= dotenv.env['CLOUD_NAME'] ?? 'No está configurado cloudinary';
  static String cloudinaryPreset = dotenv.env['PRESET'] ?? 'No está configurado  cloudinary';

}
