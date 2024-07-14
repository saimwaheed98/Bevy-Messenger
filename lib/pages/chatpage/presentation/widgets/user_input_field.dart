import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_message_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/message_option_bottom_sheet.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/voice_recording_cotainer.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/images_path.dart';

class UserInputField extends StatefulWidget {
  const UserInputField({super.key});

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: AppColors.containerBorder,
    ),
  );

  final SendMessageCubit _sendMessageCubit = Di().sl<SendMessageCubit>();

  final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();

  final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();

  final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();

  final TextEditingController _messageController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool isFieldEmpty = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _imagePickerCubit,
      builder: (context, state) {
        return state is AudioRecordingState || state is AudioRecordedState
            ? const VoiceWidget()
            : Container(
          height: 92,
          color: AppColors.fieldsColor,
          child: Row(
            children: [
              BlocBuilder(
                bloc: _imagePickerCubit,
                builder: (context, state) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.only(top: 8),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xff3B3A42),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Positioned(
                        left: 11,
                        child: IconButton(
                          onPressed: () {
                            _focusNode.unfocus();
                            showBottomSheet(
                              backgroundColor: AppColors.transparent,
                              context: context,
                              builder: (context) {
                                return MessageOptionBottomSheet();
                              },
                            );
                          },
                          icon: SvgPicture.asset(
                            AppImages.asterickIcon,
                            color: AppColors.textColor,
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 6),
              BlocBuilder(
                bloc: _imagePickerCubit,
                builder: (context, state) {
                  return Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        setState(() {
                          isFieldEmpty = value.isEmpty;
                        });
                      },
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
                  );
                },
              ),
              BlocBuilder(
                bloc: _imagePickerCubit,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (isFieldEmpty) {
                          _imagePickerCubit.startRecording();
                      } else {
                        if (_messageController.text.isNotEmpty) {
                          _getMessagesCubit.scrollController.jumpTo(_getMessagesCubit.scrollController.position.minScrollExtent);
                          String message = _messageController.text;
                          _getMessagesCubit.sendFirstMessage(_messageController.text, MessageType.text);
                          _messageController.clear();
                          if (_getMessagesCubit.messages.isEmpty &&
                              _getUserDataCubit.chatStatus ==
                                  ChatStatus.user) {
                            _sendMessageCubit.sendFirstMessage(
                                message, MessageType.text);
                          } else {
                            _sendMessageCubit.sendMessage(
                                message, "", MessageType.text);
                          }
                          setState(() {
                            isFieldEmpty = true;
                          });
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 6, right: 6),
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: isFieldEmpty
                          ? const Icon(Icons.mic, color: AppColors.white)
                          : SvgPicture.asset(AppImages.sendIcon),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();