import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/pages/data_preview_page/presentation/page/data_preview_page.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../core/di/service_locator_imports.dart';

@RoutePage()
class GalleryPage extends StatefulWidget {
  final MediumType type;
  const GalleryPage({super.key, required this.type});

  @override
  State<GalleryPage> createState() => _MyAppState();
}

class _MyAppState extends State<GalleryPage> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: widget.type);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      appBar: AppBar(
        backgroundColor: AppColors.textSecColor,
        automaticallyImplyLeading: true,
        title: const AppTextStyle(text:"Gallery", fontSize: 20, fontWeight: FontWeight.bold,maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _albums == null
              ? const Center(child: Text('No albums found'))
              : GridView.builder(
                  padding: const EdgeInsets.all(5),
                  reverse: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: _albums!.length,
                  itemBuilder: (context, index) {
                    Album album = _albums![index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AlbumPage(album: album),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.grey[300],
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: AlbumThumbnailProvider(
                                    highQuality: true,
                                    album: album,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          AppTextStyle(text: album.name ?? "Unnamed Album", fontSize: 12, fontWeight: FontWeight.w500,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          AppTextStyle(text: '${album.count} items', fontSize: 10, fontWeight: FontWeight.w300,maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}

class AlbumPage extends StatefulWidget {
  final Album album;

  AlbumPage({required this.album});

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      appBar: AppBar(
        backgroundColor: AppColors.textSecColor,
        automaticallyImplyLeading: true,
         title: AppTextStyle(text: widget.album.name ?? "Unnamed Album", fontSize: 20, fontWeight: FontWeight.bold,maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),
      body: _media == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: _media!.length,
              itemBuilder: (context, index) {
                Medium media = _media![index];
                return GestureDetector(
                  onTap: () async {
                    File? file = await PhotoGallery.getFile(mediumId: media.id);
                   if(file.path.isNotEmpty){
                     if(media.mediumType == MediumType.video){
                       _imagePickerCubit.getVideoFile(file);
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DataPreviewPage(),));
                     }else{
                       _imagePickerCubit.getImageFile(file);
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DataPreviewPage(),));
                     }
                   }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey[300],
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: MemoryImage(kTransparentImage),
                        image: ThumbnailProvider(
                          mediumId: media.id,
                          mediumType: media.mediumType,
                          highQuality: true,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// class ViewerPage extends StatelessWidget {
//   final Medium medium;
//
//   ViewerPage({required this.medium});
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime? date = medium.creationDate ?? medium.modifiedDate;
//     return Scaffold(
//       appBar: AppBar(
//         title: date != null ? Text(date.toLocal().toString()) : null,
//       ),
//       body: Center(
//         child: medium.mediumType == MediumType.image
//             ? InkWell(
//           onTap: () async {
//
//           },
//           child: FadeInImage(
//                         fit: BoxFit.cover,
//                         placeholder: MemoryImage(kTransparentImage),
//                         image: PhotoProvider(mediumId: medium.id),
//                       ),
//             )
//             : const SizedBox(),
//       ),
//     );
//   }
// }

final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
// class VideoProvider extends StatefulWidget {
//   final String mediumId;
//
//   const VideoProvider({required this.mediumId});
//
//   @override
//   _VideoProviderState createState() => _VideoProviderState();
// }
//
// class _VideoProviderState extends State<VideoProvider> {
//   VideoPlayerController? _controller;
//   File? _file;
//
//   @override
//   void initState() {
//     super.initState();
//     initAsync();
//   }
//
//   Future<void> initAsync() async {
//     _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
//     _controller = VideoPlayerController.file(_file!)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller == null || !_controller!.value.isInitialized
//         ? Center(child: CircularProgressIndicator())
//         : Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AspectRatio(
//           aspectRatio: _controller!.value.aspectRatio,
//           child: VideoPlayer(_controller!),
//         ),
//         IconButton(
//           icon: Icon(
//             _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//           onPressed: () {
//             setState(() {
//               _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
