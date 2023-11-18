




import 'package:cloudinary/cloudinary.dart';
import 'package:farrap/infraestructure/services/cloudinary_service.dart';

class CloudinaryServiceImpl extends CloudinaryService {

  
  final cloudinary = Cloudinary.unsignedConfig(cloudName: 'dd0xlct8p',);

  @override
  Future<String?> uploadPhoto(String imagePath, String? fileName) async {
    final response = await cloudinary.unsignedUpload(
      file: imagePath,
      uploadPreset: 'zzwclkgy',
      resourceType: CloudinaryResourceType.image,
      folder: 'farrapp',
      fileName: fileName);

    return response.secureUrl;
}


}