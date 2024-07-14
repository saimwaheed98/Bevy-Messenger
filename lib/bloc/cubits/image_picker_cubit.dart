import 'dart:developer';
import 'dart:io';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/image_picker.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_group_file_message_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../../pages/chatpage/data/model/message_model.dart';
import 'package:path_provider/path_provider.dart';
part '../states/image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final PickImage _pickImage;
  ImagePickerCubit(this._pickImage) : super(ImagePickerInitial());

  File? image;
  File? video;
  File? docs;
  AudioRecorder record = AudioRecorder();

  // empty the image and video
  void empty() {
    emit(ImagePickerPicking());
    image = null;
    video = null;
    docs = null;
    emit(ImagePickerInitial());
  }

  // get the image and a video
  Future<File> pickImage(ImageSource imageSource) async {
    emit(ImagePickerPicking());
    final image = await _pickImage.pickImage(imageSource);
    if (image.path.isNotEmpty) {
      this.image = image;
      emit(ImagePickerPicked());
      return image;
    } else {
      emit(ImagePickerInitial());
      return File("");
    }
  }

  // get the image file
  getImageFile(File image){
    emit(ImagePickerPicking());
    this.image = image;
    emit(ImagePickerInitial());
  }

  getDocsFile(File docs){
    emit(ImagePickerPicking());
    this.docs = docs;
    emit(ImagePickerInitial());
  }

  // get the files from the gallery
  Future<File> pickFile() async {
    emit(ImagePickerPicking());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'rtf', ".xlsx"]);
    if (result != null) {
      File file = File(result.files.single.path!);
      docs = file;
      emit(ImagePickerPicked());
      return file;
    } else {
      emit(ImagePickerInitial());
      return File("");
    }
  }

  // pick video

  // get the video file
  getVideoFile(File video){
    emit(ImagePickerPicking());
    this.video = video;
    emit(ImagePickerInitial());
  }


  Future<File> pickVideo() async {
    emit(ImagePickerPicking());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['mp4', 'mkv']);
    if (result != null) {
      File file = File(result.files.single.path!);
      video = file;
      emit(ImagePickerPicked());
      return file;
    } else {
      emit(ImagePickerInitial());
      return File("");
    }
  }

  // get recorded voice file
  bool checkEmptyField = false;
  bool isRecording = false;
  bool isRecorderStop = false;
  File? voiceFile;
  bool isSending = false;

  void sendVoiceFile() async {
    final SendFileMessageCubit sendFileMessageCubit =
        Di().sl<SendFileMessageCubit>();
    final SendGroupFileMessageCubit sendGroupFile =
        Di().sl<SendGroupFileMessageCubit>();
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
    isSending = true;
    emit(AudioRecordedState(voiceFile ?? File(""),isSending: true));
    if (getUserDataCubit.userData == null) {
      await sendGroupFile.sendFileMessage(
          voiceFile!, "", "", MessageType.audio);
      isRecording = false;
      voiceFile = null;
      isSending = false;
      log("sent");
    }
    await sendFileMessageCubit.sendFileMessage(
        voiceFile!, "", "", MessageType.audio);
    isRecording = false;
    voiceFile = null;
    isSending = false;
    log("sent");
    isRecorderStop = false;
    emit(AudioEmptyState());
  }


  Future<String?> startRecording() async {
    String? path;
    var id = const Uuid().v4();
    emit(AudioRecordingState());
    if (await record.hasPermission()) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      path = '$appDocPath/$id.flac';
        await record.start(
          path: path,
          const RecordConfig(
            androidConfig: AndroidRecordConfig(
              muteAudio: true,
              useLegacy: true,
            ),
            encoder: AudioEncoder.flac,
            echoCancel: true,
            noiseSuppress: true,
            sampleRate: 44100,
            numChannels: 2,
            bitRate: 128000,
          ),
        );
    }
    return path;
  }


  Future<void> stopRecording() async {
    emit(ImagePickerPicking());
    final path = await record.stop();
      voiceFile = File(path ?? "");
      emit(AudioRecordedState(voiceFile!));
  }

  void cancelRecording() {
    voiceFile = null;
    emit(AudioEmptyState());
  }
  // clear the image
  void clearImage() {
    emit(ImagePickerPicking());
    image = null;
    emit(ImagePickerInitial());
  }

  // clear the video
  void clearVideo() {
    emit(ImagePickerPicking());
    video = null;
    emit(ImagePickerInitial());
  }

  // clear the file
  void clearFile() {
    emit(ImagePickerPicking());
    docs = null;
    emit(ImagePickerInitial());
  }
}
