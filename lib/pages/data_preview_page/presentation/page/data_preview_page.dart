import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';
import 'package:bevy_messenger/pages/data_preview_page/presentation/widgets/asset_video_player.dart';
import 'package:bevy_messenger/pages/data_preview_page/presentation/widgets/image_preview_widget.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/images_path.dart';

@RoutePage()
class DataPreviewPage extends StatelessWidget {
  DataPreviewPage({super.key});

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: AppColors.fieldsColor,
    ),
  );

  final TextEditingController _textEditingController = TextEditingController();

  final SendFileMessageCubit _fileMessageCubit =
      Di().sl<SendFileMessageCubit>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _imagePickerCubit.empty();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.textSecColor,
        appBar: AppBar(
          backgroundColor: AppColors.textSecColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _imagePickerCubit.empty();
              AutoRouter.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return _imagePickerCubit.image == null
                        ? AssetVideoPlayer(
                            file: _imagePickerCubit.video ?? File(""))
                        : ImagePreviewWidget(
                            file: _imagePickerCubit.image ?? File(""));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _textEditingController,
                          style: const TextStyle(
                            fontFamily: 'dmSans',
                            fontSize: 14,
                            color: AppColors.textColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(
                              maxHeight: 50,
                            ),
                            hintText: 'Type Something',
                            hintStyle: const TextStyle(
                              fontFamily: 'dmSans',
                              fontSize: 14,
                              color: AppColors.textColor,
                            ),
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                          magnifierConfiguration:
                              TextMagnifier.adaptiveMagnifierConfiguration,
                          cursorColor: AppColors.textColor,
                          cursorRadius: const Radius.circular(10),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      BlocBuilder(
                        bloc: _fileMessageCubit,
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () async {
                              if (_fileMessageCubit.isSending) return;
                              if (_imagePickerCubit.image != null) {
                                File file = _imagePickerCubit.image ?? File("");
                                _getMessagesCubit
                                    .sendFirstMessage(
                                        _imagePickerCubit.image?.path ?? "",
                                        MessageType.image)
                                    .then((value) async {
                                  AutoRouter.of(context).pop();
                                  try {
                                    await _fileMessageCubit.sendFileMessage(
                                        file,
                                        "",
                                        _textEditingController.text,
                                        MessageType.image);
                                  } catch (e) {
                                    log("Error while sending file message: $e");
                                  }
                                });
                              } else {
                                File video =
                                    _imagePickerCubit.video ?? File("");
                                _getMessagesCubit.sendFirstMessage(
                                    _imagePickerCubit.video?.path ?? "",
                                    MessageType.video);
                                AutoRouter.of(context).pop();
                                await _fileMessageCubit
                                    .sendFileMessage(
                                        video,
                                        "",
                                        _textEditingController.text,
                                        MessageType.video)
                                    .then((value) {});
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
                                child: _fileMessageCubit.isSending
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
