import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum GalleryMediaType { image, video }

bool linkIsVideo(String? link) {
  if (link?.endsWith(".mp4") ?? false) {
    return true;
  }

  return false;
}

Future<String?> getMediaThumbnail(String media) async {
  final folder = (await getTemporaryDirectory()).path;
  return await VideoThumbnail.thumbnailFile(
    video: media,
    thumbnailPath: folder,
    imageFormat: ImageFormat.WEBP,
    quality: 100,
  );
}

Future<GalleryMedia> getGalleryMedia(String link) async {
  if (linkIsVideo(link)) {
    final thumbnail = await getMediaThumbnail(link);
    return GalleryMedia(file: link, thumbnail: thumbnail);
  } else {
    return GalleryMedia(file: link, thumbnail: link);
  }
}

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
      if (linkIsVideo(file)) {
        mediaType = GalleryMediaType.video;
      }
    }
  }

  ImageProvider? getThumbnailImageProvider() {
    if (thumbnail?.startsWith("http://") ?? false) {
      return CachedNetworkImageProvider(thumbnail!);
    } else if (thumbnail?.startsWith("https://") ?? false) {
      return CachedNetworkImageProvider(thumbnail!);
    } else {
      return FileImage(File(thumbnail!));
    }
  }

  Widget? getThumbnailImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (thumbnail?.startsWith("http://") ?? false)
          CachedNetworkImage(
            imageUrl: thumbnail!,
          )
        else if (thumbnail?.startsWith("https://") ?? false)
          CachedNetworkImage(
            imageUrl: thumbnail!,
          )
        else
          Image.file(File(thumbnail!)),
        if (linkIsVideo(file))
          const Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
      ],
    );
  }

  GalleryMedia copyWith({
    String? id,
    String? file,
    String? thumbnail,
  }) =>
      GalleryMedia(
        id: id ?? this.id,
        file: file ?? this.file,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory GalleryMedia.fromJson(Map<String, dynamic> json) => GalleryMedia(
        id: json["id"],
        file: json["file"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "thumbnail": thumbnail,
      };
}

class MediaGalleryPage extends StatefulWidget {
  final String? title;
  final int? startIndex;
  final List<GalleryMedia> list;
  final ImageProvider Function(GalleryMedia? file) imageProvider;
  final VideoPlayerController Function(GalleryMedia? file)
      videoPlayerController;
  const MediaGalleryPage(
      {super.key,
      this.title,
      this.startIndex = 0,
      required this.list,
      required this.imageProvider,
      required this.videoPlayerController});

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
                videoPlayerController: widget.videoPlayerController(mediaInfo));

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
