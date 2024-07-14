import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bloc/cubits/image_picker_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/enums.dart';
import '../../../chatpage/data/model/message_model.dart';
import '../../../chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import '../../../chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import '../../../chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';
import '../../../chatpage/presentation/bloc/cubit/send_group_file_message_cubit.dart';

@RoutePage()
class FilePreviewPage extends StatefulWidget {
  const FilePreviewPage({super.key});

  @override
  State<FilePreviewPage> createState() => _FilePreviewPageState();
}

class _FilePreviewPageState extends State<FilePreviewPage> {
  String fileSize = "";

  @override
  initState() {
    super.initState();
    getSize(_imagePickerCubit.docs?.lengthSync() ?? 0);
  }

  Future<String> getSize(int bytes) async {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    var size = bytes / pow(1024, i);
    fileSize = "${size.toStringAsFixed(2)} ${suffixes[i]}";
    return fileSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      appBar: AppBar(
        backgroundColor: AppColors.textSecColor,
        title: AppTextStyle(
            text: _imagePickerCubit.docs?.path.split("/").last ?? "",
            fontSize: 25,
            fontWeight: FontWeight.w500),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.galleryFileIcon,
                    height: 200,
                    width: 200,
                  ),
                  AppTextStyle(
                      text: _imagePickerCubit.docs?.path.split(".").last ?? "",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(height: 20),
              AppTextStyle(
                  text: _imagePickerCubit.docs?.path.split("/").last ?? "",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              // size of the file in kb , mb , gb etc
              AppTextStyle(
                  text: "File Size: $fileSize",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white.withOpacity(0.6),
                  textAlign: TextAlign.center),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.containerBg,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AppTextStyle(
                            text: _getUserDataCubit.groupData.name.isEmpty
                                ? _getUserDataCubit.userData.name
                                : _getUserDataCubit.groupData.name,
                            fontSize: 15,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                    BlocBuilder(
                      bloc: _groupMessageCubit,
                      builder: (context, state) {
                        return BlocBuilder(
                          bloc: _fileMessageCubit,
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                File doc = _imagePickerCubit.docs ?? File("");
                                _getMessagesCubit.sendFirstMessage(
                                    doc.path, MessageType.file);
                                AutoRouter.of(context).pop();
                                if (_getUserDataCubit.chatStatus ==
                                    ChatStatus.group) {
                                  _groupMessageCubit
                                      .sendFileMessage(
                                          doc, "", "", MessageType.file)
                                      .then((value) {
                                  });
                                } else {
                                  await _fileMessageCubit
                                      .sendFileMessage(
                                          doc, "", "", MessageType.file)
                                      .then((value) {

                                  });
                                }
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.redColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: _fileMessageCubit.isSending ||
                                          _groupMessageCubit.isSending
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : SvgPicture.asset(AppImages.sendIcon)),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
final SendGroupFileMessageCubit _groupMessageCubit =
    Di().sl<SendGroupFileMessageCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
