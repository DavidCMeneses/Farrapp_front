
import 'package:farrap/infraestructure/services/camera_gallery_service.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  
  final ImagePicker _picker = ImagePicker();
  
  @override
  Future<String?> selectPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if(image == null) return null;

    return image.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear);
    
    if(photo == null) return null;

    return photo.path;

  }


}