import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

enum GalleryMediaType { image, video }

class GalleryMedia {
  String? id;
  String? file;
  String? thumbnail;
  GalleryMediaType? mediaType;
  FlickManager? flickManager;
  GalleryMedia({this.id, this.file, this.thumbnail, this.mediaType}) {
    id ??= file;
    if (mediaType == null) {
      mediaType = GalleryMediaType.image;
      if (file?.endsWith(".mp4") ?? false) {
        mediaType = GalleryMediaType.video;
      }
    }

    if (mediaType == GalleryMediaType.video) {
      flickManager = FlickManager(
          autoPlay: false,
          videoPlayerController: VideoPlayerController.file(File(file!)));
    }
  }
}

class MediaGalleryPage extends StatefulWidget {
  final String? title;
  final int? startIndex;
  final List<GalleryMedia> list;
  final ImageProvider Function(GalleryMedia? file) imageProvider;
  const MediaGalleryPage(
      {super.key,
      this.title,
      this.startIndex = 0,
      required this.list,
      required this.imageProvider});

  @override
  State<MediaGalleryPage> createState() => _MediaGalleryPageState();
}

class _MediaGalleryPageState extends State<MediaGalleryPage> {
  late PageController pageController;
  int currentIndex = -1;
  int prevIndex = -1;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.startIndex!);
    currentIndex = widget.startIndex!;
  }

  @override
  void dispose() {
    for (var element in widget.list) {
      if (element.flickManager != null) {
        element.flickManager?.dispose();
        element.flickManager = null;
      }
    }
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Media Gallery"),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          final mediaInfo = widget.list[index];
          if (mediaInfo.mediaType == GalleryMediaType.image) {
            //return InteractiveViewer(child: Image.file(File(mediaInfo.file!)));
            return PhotoView(imageProvider: widget.imageProvider(mediaInfo));
          } else if (mediaInfo.mediaType == GalleryMediaType.video) {
            mediaInfo.flickManager ??= FlickManager(
                autoPlay: false,
                videoPlayerController:
                    VideoPlayerController.file(File(mediaInfo.file!)));

            return FlickVideoPlayer(
              flickManager: mediaInfo.flickManager!,
              flickVideoWithControls: const FlickVideoWithControls(
                videoFit: BoxFit.contain,
                controls: FlickPortraitControls(),
              ),
            );
          }
          return Container();
        },
        onPageChanged: (index) {
          prevIndex = currentIndex;
          currentIndex = index;
          final prevMedia = widget.list[prevIndex];
          if (prevMedia.flickManager != null) {
            prevMedia.flickManager?.flickControlManager?.pause();
          }
        },
      ),
    );
  }
}
