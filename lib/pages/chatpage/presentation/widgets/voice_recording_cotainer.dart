import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/cubits/image_picker_cubit.dart';
import '../../../../utils/colors.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../utils/images_path.dart';

class VoiceWidget extends StatefulWidget {
  const VoiceWidget({super.key});

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _imagePickerCubit,
      builder: (context, state) {
        return Container(
          width: getWidth(context),
          decoration: const BoxDecoration(
            color: AppColors.containerBg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is AudioRecordedState) ...[
                Row(
                  children: [
                    Expanded(
                      child: VoiceMessageView(
                        activeSliderColor: AppColors.black,
                        circlesColor: AppColors.textSecColor,
                        cornerRadius: 30,
                        backgroundColor: AppColors.textSecColor,
                        controller: VoiceController(
                          audioSrc: state.voiceFile.path,
                          maxDuration: const Duration(seconds: 60),
                          isFile: true,
                          onComplete: () {
                            debugPrint('onComplete');
                          },
                          onPause: () {
                            debugPrint('onPause');
                          },
                          onPlaying: () {
                            debugPrint('onPlaying');
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                              _imagePickerCubit.cancelRecording();
                          },
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: AppColors.redColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                              _imagePickerCubit.sendVoiceFile();

                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: state.isSending
                                ? const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.primaryColor,
                                color: AppColors.white,
                              ),
                            )
                                : SvgPicture.asset(AppImages.sendIcon),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              if (state is AudioRecordingState) ...[
                Row(
                  children: [
                    const Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.redColor,
                        color: AppColors.fieldsColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                           _imagePickerCubit.stopRecording();
                      },
                      icon: const Icon(Icons.stop_rounded),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}

final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();