import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/data_preview_page/presentation/widgets/internet_video_player_widget.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/images_path.dart';

@RoutePage()
class InternetDataPreviewPage extends StatefulWidget {
  final String url;
  final MessageType type;
  const InternetDataPreviewPage(
      {super.key, required this.url, required this.type});

  @override
  State<InternetDataPreviewPage> createState() =>
      _InternetDataPreviewPageState();
}

class _InternetDataPreviewPageState extends State<InternetDataPreviewPage> {
  double _scale = 1.0;

  Future<void> download() async {
    // Request permissions
    if (Platform.isAndroid) {
      await Permission.storage.request();
    }

    Directory? baseStorage;

    if (Platform.isAndroid) {
      baseStorage = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      baseStorage = await getApplicationDocumentsDirectory();
    }

    if (baseStorage != null) {
      final savedDir = Directory('${baseStorage.path}/Download');
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }

      await FlutterDownloader.enqueue(
        url: widget.url,
        savedDir: savedDir.path,
        showNotification: true,
        openFileFromNotification: true,
        allowCellular: true,
      );
    } else {
      print('Failed to get storage directory');
    }
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
      if (status == DownloadTaskStatus.complete) {
        WarningHelper.showSuccesToast("Task has been downloaded successfully", context);
        debugPrint('Download Complete');
      } else if (status == DownloadTaskStatus.failed) {
        debugPrint('Download failed');
        WarningHelper.showErrorToast("Error while downloading,Please check your internet connection and try again.", context);
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
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      appBar: AppBar(
        backgroundColor: AppColors.textSecColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            )),
        centerTitle: true,
        title: const AppTextStyle(
            text: "Bevy Messenger", fontSize: 24, fontWeight: FontWeight.w400),
        actions: [
          IconButton(
              onPressed: () async {
                if (await _internetConCubit.checkInternetConnection()) {
                  await download();
                } else {
                  // ignore: use_build_context_synchronously
                  WarningHelper.showWarningToast(
                      "Make sure you are connected to internet", context);
                }
              },
              icon: const Icon(
                Icons.download_rounded,
                color: AppColors.white,
              ))
        ],
      ),
      body: GestureDetector(
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              _scale = details.scale.clamp(1.0, 4.0);
            });
          },
          child: widget.type == MessageType.image
              ? Center(
                  child: Transform.scale(
                    scale: _scale,
                    child: CachedNetworkImage(
                        imageUrl: widget.url,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        repeat: ImageRepeat.noRepeat,
                        placeholder: (context, url) => Center(
                              child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(AppImages.appIcon)),
                            )),
                  ),
                )
              : InternetVideoPlayer(url: widget.url)),
    );
  }
}
