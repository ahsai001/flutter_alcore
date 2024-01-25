import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhoto {
  final String? id;
  final String? image;
  GalleryPhoto(this.id, this.image);
}

class PhotoGalleryPage extends StatelessWidget {
  final String? title;
  final List<GalleryPhoto> list;
  final ImageProvider Function(String? image) imageProvider;
  final PageController? pageController;
  final PhotoViewGalleryPageChangedCallback? onPageChanged;
  final BoxDecoration? backgroundDecoration;
  const PhotoGalleryPage(
      {super.key,
      required this.list,
      this.pageController,
      this.onPageChanged,
      this.backgroundDecoration,
      required this.imageProvider,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? "Photo Gallery"),
      ),
      body: PhotoViewGallery.builder(
        //scrollPhysics: const BouncingScrollPhysics(),
        enableRotation: true,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: imageProvider(list[index].image),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: list[index].id!),
          );
        },
        itemCount: list.length,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        backgroundDecoration: backgroundDecoration,
        pageController: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
