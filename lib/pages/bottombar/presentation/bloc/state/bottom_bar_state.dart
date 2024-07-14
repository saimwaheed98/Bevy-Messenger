part of '../cubit/bottom_bar_cubit.dart';

sealed class BottomBarState extends Equatable {
  const BottomBarState();

  @override
  List<Object> get props => [];
}

final class BottomBarInitial extends BottomBarState {}

final class BottomBarChanging extends BottomBarState {}

final class BottomBarChanged extends BottomBarState {}
