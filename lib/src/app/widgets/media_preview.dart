import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/media_gallery.dart';
import 'package:flutter_alcore/src/app/widgets/rounded_elevated_button.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaPreviewController {
  List<GalleryMedia> list = [];
}

class MediaPreviewWidget extends StatefulWidget {
  final MediaPreviewController mediaPreviewController;
  final Widget Function(BuildContext context)? emptyWidget;
  const MediaPreviewWidget(
      {super.key, required this.mediaPreviewController, this.emptyWidget});

  @override
  State<MediaPreviewWidget> createState() => _MediaPreviewWidgetState();
}

class _MediaPreviewWidgetState extends State<MediaPreviewWidget> {
  final ImagePicker picker = ImagePicker();

  Future<bool> takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      widget.mediaPreviewController.list
          .add(GalleryMedia(file: photo.path, thumbnail: photo.path));
      return true;
    }

    return false;
  }

  Future<bool> takeVideo() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      final folder = (await getTemporaryDirectory()).path;
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: video.path,
        thumbnailPath: folder,
        imageFormat: ImageFormat.WEBP,
        quality: 100,
      );
      widget.mediaPreviewController.list
          .add(GalleryMedia(file: video.path, thumbnail: thumbnail));
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedElevatedButton(
              child: const Text("Add Photo"),
              onPressed: () async {
                if (await takePhoto()) {
                  setState(() {});
                }
              },
            ),
            const SpaceWidth(),
            RoundedElevatedButton(
              child: const Text("Add Video"),
              onPressed: () async {
                if (await takeVideo()) {
                  setState(() {});
                }
              },
            ),
          ],
        ),
        const SpaceHeight(),
        if (widget.mediaPreviewController.list.isEmpty)
          widget.emptyWidget != null
              ? widget.emptyWidget!.call(context)
              : const Text("No media attached")
        else
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0),
            itemBuilder: (context, index) {
              return FileThumbnailWidget(
                mediaInfo: widget.mediaPreviewController.list[index],
                removeCallback: () {
                  setState(() {
                    final file =
                        File(widget.mediaPreviewController.list[index].file!);
                    widget.mediaPreviewController.list.removeAt(index);
                    file.deleteSync();
                  });
                },
                openCallback: () {
                  pushNewPageWithTransition(
                      context,
                      (context) => MediaGalleryPage(
                            list: widget.mediaPreviewController.list,
                            startIndex: index,
                            imageProvider: (mediaInfo) {
                              return FileImage(File(mediaInfo!.file!));
                            },
                            videoPlayerController: (GalleryMedia? file) {
                              return VideoPlayerController.file(
                                  File(file!.file!));
                            },
                          ));
                },
              );
            },
            itemCount: widget.mediaPreviewController.list.length,
          ),
        const SpaceHeight(),
      ],
    );
  }
}

class FileThumbnailWidget extends StatelessWidget {
  final GalleryMedia mediaInfo;
  final void Function() removeCallback;
  final void Function() openCallback;
  const FileThumbnailWidget(
      {super.key,
      required this.mediaInfo,
      required this.removeCallback,
      required this.openCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openCallback.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.file(
            File(mediaInfo.thumbnail!),
            fit: BoxFit.fitWidth,
          ),
          if (mediaInfo.file!.endsWith(".mp4"))
            const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                removeCallback.call();
              },
              child: const CircleAvatar(
                radius: 13,
                child: Icon(
                  Icons.close_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
