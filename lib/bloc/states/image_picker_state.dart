part of '../cubits/image_picker_cubit.dart';

class ImagePickerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerPicking extends ImagePickerState {}

class ImagePickerPicked extends ImagePickerState {}

// Audio recording states
class AudioRecordingState extends ImagePickerState {}

class AudioRecordingStopState extends ImagePickerState {}

class AudioRecordedState extends ImagePickerState {
  final File voiceFile;
  final bool isSending;

  AudioRecordedState(this.voiceFile, {this.isSending = false});

  @override
  List<Object?> get props => [voiceFile, isSending];
}

class AudioEmptyState extends ImagePickerState {}