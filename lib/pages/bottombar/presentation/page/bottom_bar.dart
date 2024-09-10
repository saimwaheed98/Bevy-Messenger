import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/get_notification_click_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';
import 'package:bevy_messenger/pages/bottombar/presentation/widgets/bottom_bar_widget.dart';
import 'package:bevy_messenger/pages/gallery/presentation/bloc/cubit/gallery_cubit.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../addusers/presentation/bloc/cubit/get_user_cubit.dart';

@RoutePage()
class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final GetNotificationClickCubit _getNotificationClickCubit =
      Di().sl<GetNotificationClickCubit>();
  final InternetConCubit _internetConCubit = Di().sl<InternetConCubit>();
  final GalleryCubit _galleryCubit = Di().sl<GalleryCubit>();

  @override
  void initState() {
    _getNotificationClickCubit.getNotificationClick(context);
    _getNotificationClickCubit.handleInteractedMessage(context);
    _getUserCubit.fetchContactsAndUsers();
    _galleryCubit.requestPermission();
    _internetConCubit.listenToConnectivityChanges();
    init();
    super.initState();
  }

  // init
  Future<void> init() async {
    String token = await AuthDataSource.getFirebaseMessagingToken();
    await AuthDataSource.updatePushToken(token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _barCubit,
      builder: (context, state) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () {
            if (_barCubit.currentIndex != 0) {
              _barCubit.changeIndex(0);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.textSecColor,
            body: _barCubit.screens[_barCubit.currentIndex],
            floatingActionButton: const BottomBarWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final BottomBarCubit _barCubit = Di().sl<BottomBarCubit>();
final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();
