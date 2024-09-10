import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/core/initialization/app_initializer.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/data_preview_page/presentation/widgets/internet_video_player_widget.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/files_ext_paths.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import '../../../../utils/images_path.dart';
import 'package:http/http.dart' as http;

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

  Future<void> downloadAndOpenFile(
      String url, String fileName, BuildContext context) async {
    try {
      // Show the notification for downloading
      _showNotification(
        id: 0,
        title: 'Downloading',
        body: 'Downloading $fileName...',
      );

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        debugPrint('File downloaded ');

        if (videoExt.contains(fileName.split(".").last)) {
          debugPrint("saving video");
          var appDocDir = await getTemporaryDirectory();
          String savePath = "${appDocDir.path}/$fileName";

          final file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);

          await SaverGallery.saveFile(
              file: file.path, name: fileName, androidExistNotSave: true);
        } else {
          debugPrint("saving image");
          await SaverGallery.saveImage(response.bodyBytes,
              name: fileName, androidExistNotSave: true);
        }
        _showNotification(
          id: 0,
          title: 'Download Complete',
          body: '$fileName has been downloaded successfully.',
        );
        WarningHelper.showSuccesToast(
            "File has been saved successfully", context);
      } else {
        _showNotification(
          id: 0,
          title: 'Download Failed',
          body: 'Failed to download $fileName.',
        );
        WarningHelper.showErrorToast("Failed to save the file", context);
        debugPrint('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      _showNotification(
        id: 0,
        title: 'Download Failed',
        body: 'An error occurred while downloading $fileName.',
      );
      WarningHelper.showErrorToast("Failed to save the file", context);
      debugPrint('Error occurred while downloading the file: $e');
    }
  }

  Future<void> _showNotification(
      {required int id,
      required String title,
      required String body,
      List<AndroidNotificationAction>? actions}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Channel for download notifications',
      importance: Importance.max,
      colorized: true,
      color: AppColors.primaryColor,
      priority: Priority.high,
      ticker: 'ticker',
      actions: actions,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Download',
    );
  }

  Future<bool> _requestPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status == PermissionStatus.granted;
    } else {
      final status = await Permission.storage.request();
      return status == PermissionStatus.granted;
    }
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
                  // await download();
                  String getFilenameFromUrl(String url) {
                    Uri uri = Uri.parse(url);
                    String path = uri.path;
                    List<String> segments = path.split('/');
                    return segments.last;
                  }

                  String getFileNameFromEncodedUrl() {
                    String decodedUrl =
                        Uri.decodeComponent(getFilenameFromUrl(widget.url));
                    List<String> segments = decodedUrl.split('/');
                    return segments.last;
                  }

// _showNotification(id: 4, title: "Hello", body: "didhidhdhid");
                  await downloadAndOpenFile(
                      widget.url, getFileNameFromEncodedUrl(), context);
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
