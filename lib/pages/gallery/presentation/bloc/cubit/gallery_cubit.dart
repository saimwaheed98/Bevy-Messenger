import 'dart:async';
import 'dart:developer';

import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/files_ext_paths.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../datasources/data/file_reader.dart';

part '../state/gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  final _fileLoader = FileLoader();

  List <String> files = [];
  List <String> gallery = [];
  List <String> videos = [];
  bool isGetting = false;

  GalleryType type = GalleryType.gallery;


  changeType(GalleryType type){
    emit(GettingGallery());
    this.type = type;
    emit(GalleryGetted());
  }


  // get all the files
  List<String> fileData = [];
  // get the files according to the type the user want

  getFile(){
    emit(GettingGallery());
    if(type == GalleryType.files){
      fileData = files;
      log("Lenght of files (${fileData})");
    }else if(type == GalleryType.videos){
      fileData = videos;
    }else{
      fileData = gallery ;
    }
    emit(GalleryGetted());
  }


  Future<void> requestPermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();
      if (statuses[Permission.manageExternalStorage]!.isGranted) {
        getFiles();
        getGallery();
        getVideos();
      } else {
        log('Storage permission denied');
      }
    } catch (e) {
      log('Error getting files: $e');
    }
  }

  Future<void> getGallery()async{
    try{
      emit(GettingGallery());
      isGetting = true;
      List<String> files = await _fileLoader.loadFiles(imageExt);
      gallery = files;
      isGetting = false;
      log(files.length.toString());
      emit(GalleryGetted());
    }catch(e){
      log('Error getting files: $e');
      isGetting = false;
      emit(GalleryError());
    }
  }
  Future<void> getFiles()async{
    try{
      emit(GettingGallery());
      isGetting = true;
      List<String> files = await _fileLoader.loadFiles(videoExt);
      videos = files;
      isGetting = false;
      emit(GalleryGetted());
      log(files.length.toString());
    }catch(e){
      log('Error getting files: $e');
      isGetting = false;
      emit(GalleryError());
    }
  }
  Future<void> getVideos()async{
    try{
      emit(GettingGallery());
      isGetting = true;
      List<String> docs = await _fileLoader.loadFiles(filesExt);
      files = docs;
      isGetting = false;
      emit(GalleryGetted());
      log(docs.length.toString());
    }catch(e){
      log('Error getting files: $e');
      isGetting = false;
      emit(GalleryError());
    }
  }
}