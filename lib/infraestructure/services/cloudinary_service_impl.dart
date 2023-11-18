




import 'package:cloudinary/cloudinary.dart';
import 'package:farrap/config/constants/environment.dart';
import 'package:farrap/infraestructure/services/cloudinary_service.dart';

class CloudinaryServiceImpl extends CloudinaryService {

  
  final cloudinary = Cloudinary.unsignedConfig(cloudName: Environment.cloudinaryCloudName,);

  @override
  Future<String?> uploadPhoto(String imagePath, String? fileName) async {
    final response = await cloudinary.unsignedUpload(
      file: imagePath,
      uploadPreset: Environment.cloudinaryPreset,
      resourceType: CloudinaryResourceType.image,
      folder: 'farrapp',
      fileName: fileName);

    return response.secureUrl;
}


}