part of '../cubit/gallery_cubit.dart';

sealed class GalleryState extends Equatable {
  const GalleryState();
}

final class GalleryInitial extends GalleryState {
  @override
  List<Object> get props => [];
}

final class GettingGallery extends GalleryState {
  @override
  List<Object> get props => [];
}

final class GalleryGetted extends GalleryState {
  @override
  List<Object> get props => [];
}
final class GalleryError extends GalleryState {
  @override
  List<Object> get props => [];
}
