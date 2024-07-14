import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/gallery/presentation/bloc/cubit/gallery_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../bloc/cubits/image_picker_cubit.dart';
import '../../../../routes/routes_imports.gr.dart';
import '../../../chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';

@RoutePage()
class FileViewerPage extends StatefulWidget {
  const FileViewerPage({super.key});

  @override
  State<FileViewerPage> createState() => _FileViewerAppState();
}

class _FileViewerAppState extends State<FileViewerPage> {
  final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
  final GalleryCubit _galleryCubit = Di().sl<GalleryCubit>();

  @override
  void initState() {
    super.initState();
    _galleryCubit.getFile();
    if (_galleryCubit.type == GalleryType.files &&
        _galleryCubit.files.isEmpty) {
      _galleryCubit.getFile();
    } else if (_galleryCubit.type == GalleryType.videos &&
        _galleryCubit.videos.isEmpty) {
      _galleryCubit.getVideos();
    } else if (_galleryCubit.type == GalleryType.gallery &&
        _galleryCubit.gallery.isEmpty) {
      _galleryCubit.getGallery();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _galleryCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.textSecColor,
          appBar: AppBar(
            backgroundColor: AppColors.textSecColor,
            centerTitle: true,
            title: AppTextStyle(
                text: _galleryCubit.type == GalleryType.gallery
                    ? "Gallery"
                    : _galleryCubit.type == GalleryType.videos
                        ? "Videos"
                        : 'Documents',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                textAlign: TextAlign.center),
          ),
          body: _galleryCubit.isGetting
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                    color: AppColors.textSecColor,
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _galleryCubit.fileData.length,
                  itemBuilder: (context, index) {
                    final file = File(_galleryCubit.fileData[index]);
                    return InkWell(
                      borderRadius: BorderRadius.circular(15),
                      splashColor: AppColors.primaryColor.withOpacity(0.3),
                      onTap: () {
                        _fileMessageCubit.isSending = false;
                        if (_galleryCubit.type == GalleryType.gallery) {
                          _imagePickerCubit.getImageFile(
                              File(_galleryCubit.fileData[index]));
                          AutoRouter.of(context)
                              .replace(DataPreviewPageRoute());
                        } else if (_galleryCubit.type == GalleryType.videos) {
                          _imagePickerCubit.getVideoFile(
                              File(_galleryCubit.fileData[index]));
                          AutoRouter.of(context)
                              .replace(DataPreviewPageRoute());
                        } else {
                          _imagePickerCubit
                              .getDocsFile(File(_galleryCubit.fileData[index]));
                          AutoRouter.of(context)
                              .replace(const FilePreviewPageRoute());
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.containerBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _galleryCubit.type == GalleryType.gallery
                            ? FutureBuilder<bool>(
                                future: _checkIfImageIsValid(file),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError ||
                                      snapshot.data == false) {
                                    return const Center(
                                        child: Text('Invalid Image'));
                                  } else {
                                    return Image.file(file);
                                  }
                                },
                              )
                            : _galleryCubit.type == GalleryType.videos
                                ? VideoThumbnailPreview(file: file)
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          AppImages.galleryFileIcon,
                                          height: 64,
                                          width: 64),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: AppTextStyle(
                                            text: _galleryCubit.fileData[index]
                                                .split('/')
                                                .last,
                                            fontSize: 15,
                                            maxLines: 2,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Future<bool> _checkIfImageIsValid(File file) async {
    try {
      final image = await decodeImageFromList(file.readAsBytesSync());
      return image != null;
    } catch (e) {
      return false;
    }
  }
}

class VideoThumbnailPreview extends StatelessWidget {
  final File file;
  const VideoThumbnailPreview({super.key, required this.file});

  Future<String?> _getVideoThumbnail(File file) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: file.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 160,
      maxWidth: 170,
      quality: 75,
    );
    return thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getVideoThumbnail(file),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text('Failed to generate thumbnail'));
        } else {
          return Image.file(File(snapshot.data!));
        }
      },
    );
  }
}

final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
