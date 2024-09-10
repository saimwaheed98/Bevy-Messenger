import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_group_file_message_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/page/camera_page.dart';
import 'package:bevy_messenger/pages/gallery/presentation/bloc/cubit/gallery_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../routes/routes_imports.gr.dart';

class MessageOptionBottomSheet extends StatefulWidget {
  const MessageOptionBottomSheet({super.key});

  @override
  State<MessageOptionBottomSheet> createState() =>
      _MessageOptionBottomSheetState();
}

class _MessageOptionBottomSheetState extends State<MessageOptionBottomSheet> {
  final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
  final GalleryCubit _galleryCubit = Di().sl<GalleryCubit>();

  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    if (cameras.isNotEmpty) {
      XFile imagePath = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(camera: cameras.first),
        ),
      );
      if (imagePath.path.isNotEmpty) {
        debugPrint('Image saved at ${imagePath.path}');
        _imagePickerCubit.getImageFile(File(imagePath.path));
        AutoRouter.of(context).push(DataPreviewPageRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 4,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.fieldsColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              singleMessageOptionWidget(() {
                _pickImage();
              }, AppImages.cameraIcon, "Camera"),
              singleMessageOptionWidget(() {
                if (Platform.isAndroid) {
                   Navigator.of(context).pop();
                  _galleryCubit.changeType(GalleryType.gallery);
                  AutoRouter.of(context).push(const FileViewerPageRoute());
                } else {
                  _imagePickerCubit
                      .pickImage(ImageSource.gallery)
                      .then((value) {
                    Navigator.of(context).pop();
                    if (value.path.isNotEmpty) {
                      AutoRouter.of(context).push(DataPreviewPageRoute());
                    }
                  });
                }
              }, AppImages.imageIcon, "Gallery"),
              singleMessageOptionWidget(() {
                if (Platform.isAndroid) {
                  _galleryCubit.changeType(GalleryType.files);
                  Navigator.of(context).pop();
                  AutoRouter.of(context).push(const FileViewerPageRoute());
                } else {
                  _imagePickerCubit.pickFile().then((value) async {
                    Navigator.of(context).pop();
                    if (value.path.isEmpty) return;
                    AutoRouter.of(context).push(const FilePreviewPageRoute());
                  });
                }
              }, AppImages.documentIcon, "Documents"),
              singleMessageOptionWidget(() {
                if (Platform.isAndroid) {
                  _galleryCubit.changeType(GalleryType.videos);
                  Navigator.of(context).pop();
                  AutoRouter.of(context).push(const FileViewerPageRoute());
                } else {
                  _imagePickerCubit.pickVideo().then((value) {
                    Navigator.of(context).pop();
                    if (value.path.isNotEmpty) {
                      AutoRouter.of(context).push(DataPreviewPageRoute());
                    }
                  });
                }
              }, AppImages.videoIcon, "Video"),
            ],
          ),
        ),
        const SizedBox(
          height: 110,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: const EdgeInsets.only(top: 8),
              height: 50,
              width: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: const Color(0xff3B3A42),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const AppTextStyle(
                  text: "*",
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor),
            ),
          ),
        ),
      ],
    );
  }
}

final SendGroupFileMessageCubit _groupMessageCubit =
    Di().sl<SendGroupFileMessageCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();

Widget singleMessageOptionWidget(Function()? onTap, String image, String name) {
  return InkWell(
    onTap: onTap,
    splashColor: AppColors.transparent,
    child: Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withOpacity(0.7),
                    AppColors.white.withOpacity(0.3),
                  ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        AppTextStyle(text: name, fontSize: 12, fontWeight: FontWeight.w600)
      ],
    ),
  );
}
