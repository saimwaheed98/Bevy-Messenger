import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/docs_message_container.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatDataDialog extends StatelessWidget {
  const ChatDataDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.containerBg,
      surfaceTintColor: AppColors.containerBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder(
              bloc: _getMessagesCubit,
              builder: (context, state) {
                return Container(
                  height: 40,
                  width: 220,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.containerBorder, width: 1),
                    color: AppColors.fieldsColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: AppColors.textSecColor,
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: AppColors.textSecColor,
                        onTap: () {
                          _getMessagesCubit.changeValue(0);
                        },
                        child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getMessagesCubit.messageValue == 0
                                ? AppColors.containerBg
                                : null,
                            boxShadow: _getMessagesCubit.messageValue == 0
                                ? [
                                    BoxShadow(
                                        color: AppColors.black.withOpacity(0.3),
                                        blurRadius: 2,
                                        spreadRadius: 2)
                                  ]
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const AppTextStyle(
                              text: "Media",
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        splashColor: AppColors.textSecColor,
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: AppColors.textSecColor,
                        onTap: () {
                          _getMessagesCubit.changeValue(1);
                        },
                        child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getMessagesCubit.messageValue == 1
                                ? AppColors.containerBg
                                : null,
                            boxShadow: _getMessagesCubit.messageValue == 1
                                ? [
                                    BoxShadow(
                                        color: AppColors.black.withOpacity(0.3),
                                        blurRadius: 2,
                                        spreadRadius: 2)
                                  ]
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const AppTextStyle(
                              text: "Docs",
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder(
              bloc: _getMessagesCubit,
              builder: (context, state) {
                if (_getMessagesCubit.messageValue == 0 &&
                    _getMessagesCubit.mediaMessages.isNotEmpty) {
                  return SizedBox(
                      height: 400,
                      width: getWidth(context) * 0.8,
                      child: MasonryGridView.builder(
                        itemCount: _getMessagesCubit.mediaMessages.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          var data = _getMessagesCubit.mediaMessages[index];
                          bool isImage = data.type == MessageType.image.name;
                          return isImage
                              ? InkWell(
                                  highlightColor: AppColors.transparent,
                                  splashColor: AppColors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {
                                    AutoRouter.of(context).push(
                                        InternetDataPreviewPageRoute(
                                            url: data.message,
                                            type: MessageType.image));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: data.message,
                                            errorWidget: (context, url, error) {
                                              return const Icon(Icons.error);
                                            },
                                            placeholder: (context, url) {
                                              return const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            AppColors
                                                                .secondaryColor,
                                                        color:
                                                            AppColors.textColor,
                                                      )),
                                                ],
                                              );
                                            },
                                          )),
                                    ),
                                  ),
                                )
                              : FutureBuilder<Uint8List?>(
                                  future: generateThumbnail(data.message),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return InkWell(
                                        highlightColor: AppColors.transparent,
                                        splashColor: AppColors.transparent,
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {
                                          AutoRouter.of(context).push(
                                              InternetDataPreviewPageRoute(
                                                  url: data.message,
                                                  type: MessageType.video));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.memory(snapshot.data ??
                                                    Uint8List(0)),
                                                const Icon(
                                                  Icons.play_arrow,
                                                  color: AppColors.white,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        height: 180,
                                        width: 180,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: 25,
                                                width: 25,
                                                child:
                                                    CircularProgressIndicator()),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                );
                        },
                      ));
                } else if (_getMessagesCubit.messageValue == 0 &&
                    _getMessagesCubit.mediaMessages.isEmpty) {
                  return SizedBox(
                      height: 400,
                      width: getWidth(context) * 0.8,
                      child: const AppTextStyle(
                          text: "No Media Found In This Chat.",
                          fontSize: 18,
                          fontWeight: FontWeight.bold));
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder(
              bloc: _getMessagesCubit,
              builder: (context, state) {
                if (_getMessagesCubit.messageValue == 1 &&
                    _getMessagesCubit.docsMessages.isNotEmpty) {
                  return SizedBox(
                    height: 400,
                    width: getWidth(context) * 0.8,
                    child: ListView.builder(
                      itemCount: _getMessagesCubit.docsMessages.length,
                      itemBuilder: (context, index) {
                        var data = _getMessagesCubit.docsMessages[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                                child: DocsMessageContainer(
                                  message: data,
                                  backgroundColor: AppColors.containerBg,
                                )),
                          ],
                        );
                      },
                    ),
                  );
                } else if (_getMessagesCubit.messageValue == 1 &&
                    _getMessagesCubit.docsMessages.isEmpty) {
                  return SizedBox(
                      height: 400,
                      width: getWidth(context) * 0.8,
                      child: const AppTextStyle(
                          text: "No Docs Found In This Chat.",
                          fontSize: 18,
                          fontWeight: FontWeight.bold));
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> generateThumbnail(String videoUrl) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 180,
      maxHeight: 180,
      quality: 100,
    );
    return thumbnail;
  }
}

final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
