import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../bloc/cubits/internet_con_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../helper/toast_messages.dart';
import '../../bloc/cubit/get_user_data_cubit.dart';
import '../../bloc/cubit/send_file_message_cubit.dart';

class DocsMessageContainer extends StatefulWidget {
  final MessageModel message;
  final Color backgroundColor;
  final String? read;
  const DocsMessageContainer({
    Key? key,
    this.backgroundColor = Colors.white,
    this.read,
    required this.message,
  }) : super(key: key);

  @override
  State<DocsMessageContainer> createState() => _DocsMessageContainerState();
}

class _DocsMessageContainerState extends State<DocsMessageContainer> {
  Future download() async {
    await Permission.storage.request();
    Directory? baseStorage;
    if (Platform.isAndroid) {
      baseStorage = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      baseStorage = await getApplicationDocumentsDirectory();
    }
    await FlutterDownloader.enqueue(
      url: widget.message.message,
      savedDir: baseStorage!.path,
      showNotification: true,
      openFileFromNotification: true,
      allowCellular: true,
      saveInPublicStorage: true,
    );
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
      if (status == DownloadTaskStatus.complete) {
        WarningHelper.showSuccesToast(
            "Task has been downloaded successfully", context);
        debugPrint('Download Complete');
      } else if (status == DownloadTaskStatus.failed) {
        debugPrint('Download failed');
        WarningHelper.showErrorToast(
            "Error while downloading,Please check your internet connection and try again.",
            context);
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  final InternetConCubit _internetConCubit = Di().sl<InternetConCubit>();

  @override
  Widget build(BuildContext context) {
    bool isSending =
        _fileMessageCubit.sendingMessageId == widget.message.messageId &&
            _fileMessageCubit.isSending;
    String getFilenameFromUrl(String url) {
      Uri uri = Uri.parse(url);
      String path = uri.path;
      List<String> segments = path.split('/');
      return segments.last;
    }

    String getFileNameFromEncodedUrl() {
      String decodedUrl =
          Uri.decodeComponent(getFilenameFromUrl(widget.message.message));
      List<String> segments = decodedUrl.split('/');
      return segments.last;
    }

    return BlocBuilder(
      bloc: _fileMessageCubit,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                if (isSending == false) {
                  if (await _internetConCubit.checkInternetConnection()) {
                    await download();
                  } else {
                    // ignore: use_build_context_synchronously
                    WarningHelper.showWarningToast(
                        "Make sure you are connected to internet", context);
                  }
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                constraints: const BoxConstraints(maxWidth: 280),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.textColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.documentIcon,
                              height: 50, width: 50),
                          Expanded(
                            child: AppTextStyle(
                                text: getFileNameFromEncodedUrl(),
                                fontSize: 18,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if(isSending && state is SendFileMessageFailure)
              CircleAvatar(
                backgroundColor: AppColors.textColor.withOpacity(0.7),
                radius: 10,
                child: const AppTextStyle(text: "!", fontSize: 15, fontWeight: FontWeight.w500,color: AppColors.redColor,) ,
              ),
            if (isSending && !_fileMessageCubit.sendingFailed)
              const Icon(CupertinoIcons.clock,
                  color: AppColors.redColor, size: 18),
            if (_getUserDataCubit.chatStatus == ChatStatus.user &&
                isSending == false) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.message.read.isNotEmpty)
                    const Icon(
                      Icons.done_all,
                      color: AppColors.redColor,
                      size: 18,
                    ),
                  if (widget.message.userOnlineState == true &&
                      widget.message.read.isEmpty)
                    const Icon(
                      Icons.done,
                      color: AppColors.redColor,
                      size: 18,
                    ),
                ],
              ),
              if (widget.message.userOnlineState == false &&
                  widget.message.read.isEmpty)
                const Icon(
                  Icons.done,
                  color: AppColors.white,
                  size: 18,
                ),
            ],
            // if (_getUserDataCubit.chatStatus == ChatStatus.user &&
            //     (widget.read?.isNotEmpty ?? false))
            //   const Icon(
            //     Icons.done_all,
            //     color: AppColors.redColor,
            //     size: 18,
            //   ),
            // if (_getUserDataCubit.chatStatus == ChatStatus.user &&
            //     (widget.read?.isEmpty ?? false))
            //   Icon(
            //     Icons.done,
            //     color: AppColors.white.withOpacity(0.7),
            //     size: 18,
            //   ),
          ],
        );
      },
    );
  }
}

final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
