import 'dart:io';

import 'package:farrap/infraestructure/services/camera_gallery_service_impl.dart';
import 'package:flutter/material.dart';

class TakePhoto extends StatelessWidget {
  final String image;
  final Function(String image) onChangedImage;

  const TakePhoto({super.key, required this.image, required this.onChangedImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
              "Selecciona o haz una foto del establecimiento",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                      padding: const EdgeInsets.only(right: 30),
                      iconSize: 70,
                      onPressed: () async {
                        final photoPath = await CameraGalleryServiceImpl().takePhoto();
                        if(photoPath == null) return;
                    
                        onChangedImage(photoPath);
                      }, 
                      icon: const Icon(Icons.camera_alt_outlined)
                      ),
                  ),
                  Expanded(
                    child: IconButton(
                      padding: const EdgeInsets.only(left: 30),
                      iconSize: 70,
                      onPressed: () async {
                        final photoPath = await CameraGalleryServiceImpl().selectPhoto();
                        if(photoPath == null) return;
                    
                        onChangedImage(photoPath);
                      }, 
                      icon: const Icon(Icons.photo_library_outlined)
                      ),
                  ),
                ],
              ),
            ),
            _ImageViewer(image: image),
            
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {

  final String image;

  const _ImageViewer({ required this.image });

  @override
  Widget build(BuildContext context) {
    
    if ( image.isEmpty ) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/no-image.jpg', 
          fit: BoxFit.fitWidth,

        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.fitWidth,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        image: FileImage( File(image) ),
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
      ),
    );

  }
}