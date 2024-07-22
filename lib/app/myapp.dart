import 'package:bevy_messenger/configs/zego_cloud_config.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../routes/routes_imports.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.navigatorKey});

  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (AuthDataSource.auth.currentUser != null) {
      AuthDataSource.getSelfInfo().then((value) {
        ZegoUIKitPrebuiltCallInvitationService().init(
          appID: ZegoCLouds.appId,
          appSign: ZegoCLouds.appSignIn,
          userID: value.id,
          userName: value.name,
          plugins: [
            ZegoUIKitSignalingPlugin(

            ),
          ],
          notificationConfig: ZegoCallInvitationNotificationConfig(
            androidNotificationConfig: ZegoCallAndroidNotificationConfig(
              showFullScreen: true,
              channelID: "ZegoUIKit",
              channelName: "Call Notifications",
              sound: "call",
              icon: "call",
            ),
            iOSNotificationConfig: ZegoCallIOSNotificationConfig(
              systemCallingIconName: 'CallKitIcon',
            ),
          ),
          requireConfig: (ZegoCallInvitationData data) {
            final config = (data.invitees.length > 1)
                ? ZegoCallType.videoCall == data.type
                    ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                    : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                : ZegoCallType.videoCall == data.type
                    ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                    : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

            /// support minimizing, show minimizing button
            config.topMenuBar.isVisible = true;
            config.topMenuBar.buttons
                .insert(0, ZegoCallMenuBarButtonName.minimizingButton);
            config.topMenuBar.buttons
                .insert(0, ZegoCallMenuBarButtonName.soundEffectButton);

            return config;
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(
      navigatorKey: widget.navigatorKey,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bevy Messenger',
      routerConfig: router.config(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
