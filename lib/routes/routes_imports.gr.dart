// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:bevy_messenger/pages/addusers/presentation/page/add_users_page.dart'
    as _i1;
import 'package:bevy_messenger/pages/blocklist/presentation/page/block_user_page.dart'
    as _i2;
import 'package:bevy_messenger/pages/bottombar/presentation/page/bottom_bar.dart'
    as _i15;
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart'
    as _i28;
import 'package:bevy_messenger/pages/chatpage/presentation/page/chat_page.dart'
    as _i3;
import 'package:bevy_messenger/pages/chatroom/presentation/page/chat_room_page.dart'
    as _i4;
import 'package:bevy_messenger/pages/creategroup/presentation/page/create_group_page.dart'
    as _i5;
import 'package:bevy_messenger/pages/data_preview_page/presentation/page/data_preview_page.dart'
    as _i6;
import 'package:bevy_messenger/pages/data_preview_page/presentation/page/file_preview_page.dart'
    as _i8;
import 'package:bevy_messenger/pages/data_preview_page/presentation/page/internet_data_preview_page.dart'
    as _i16;
import 'package:bevy_messenger/pages/editprofile/presentation/page/edit_profile_page.dart'
    as _i7;
import 'package:bevy_messenger/pages/forgot_password/prsentation/page/forgot_password_page.dart'
    as _i10;
import 'package:bevy_messenger/pages/gallery/presentation/pages/files_page.dart'
    as _i9;
import 'package:bevy_messenger/pages/gallery/presentation/pages/gallery_images_page.dart'
    as _i11;
import 'package:bevy_messenger/pages/getStarted/presentation/page/get_started_page.dart'
    as _i12;
import 'package:bevy_messenger/pages/groupinfo/presentation/page/group_info_page.dart'
    as _i13;
import 'package:bevy_messenger/pages/grouplist/presentation/page/group_list.dart'
    as _i14;
import 'package:bevy_messenger/pages/login/presentation/page/login_page.dart'
    as _i17;
import 'package:bevy_messenger/pages/otp/presentation/page/otp_page.dart'
    as _i18;
import 'package:bevy_messenger/pages/privatechats/presentation/page/private_chat_page.dart'
    as _i19;
import 'package:bevy_messenger/pages/signup/presentation/page/sign_up_page.dart'
    as _i20;
import 'package:bevy_messenger/pages/splash/page/splash_page.dart' as _i21;
import 'package:bevy_messenger/pages/subscription/presentation/page/subscription_page.dart'
    as _i22;
import 'package:bevy_messenger/pages/userProfile/presentation/page/user_profile_page.dart'
    as _i23;
import 'package:bevy_messenger/utils/enums.dart' as _i27;
import 'package:flutter/material.dart' as _i25;
import 'package:photo_gallery/photo_gallery.dart' as _i26;

abstract class $AppRouter extends _i24.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i24.PageFactory> pagesMap = {
    AddUserPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddUserPageRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddUserPage(
          key: args.key,
          onTap: args.onTap,
          isAdding: args.isAdding,
          isAddingInfo: args.isAddingInfo,
        ),
      );
    },
    BlockUserPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BlockUserPage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatPage(),
      );
    },
    ChatRoomPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChatRoomPage(),
      );
    },
    CreateGroupRoute.name: (routeData) {
      final args = routeData.argsAs<CreateGroupRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.CreateGroup(
          key: args.key,
          isRoom: args.isRoom,
        ),
      );
    },
    DataPreviewPageRoute.name: (routeData) {
      final args = routeData.argsAs<DataPreviewPageRouteArgs>(
          orElse: () => const DataPreviewPageRouteArgs());
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.DataPreviewPage(key: args.key),
      );
    },
    EditProfilePageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EditProfilePage(),
      );
    },
    FilePreviewPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.FilePreviewPage(),
      );
    },
    FileViewerPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.FileViewerPage(),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ForgotPasswordPage(),
      );
    },
    GalleryPageRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPageRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.GalleryPage(
          key: args.key,
          type: args.type,
        ),
      );
    },
    GetStartedPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.GetStartedPage(),
      );
    },
    GroupInfoPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.GroupInfoPage(),
      );
    },
    GroupListRoute.name: (routeData) {
      final args = routeData.argsAs<GroupListRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.GroupList(
          key: args.key,
          title: args.title,
          premium: args.premium,
          category: args.category,
        ),
      );
    },
    HomeBottomBarRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.HomeBottomBar(),
      );
    },
    InternetDataPreviewPageRoute.name: (routeData) {
      final args = routeData.argsAs<InternetDataPreviewPageRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.InternetDataPreviewPage(
          key: args.key,
          url: args.url,
          type: args.type,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.LoginPage(),
      );
    },
    OtpPageRoute.name: (routeData) {
      final args = routeData.argsAs<OtpPageRouteArgs>(
          orElse: () => const OtpPageRouteArgs());
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.OtpPage(key: args.key),
      );
    },
    PrivateChatPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.PrivateChatPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.SignUpPage(),
      );
    },
    SplashPageRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.SplashPage(),
      );
    },
    SubscriptionPageRoute.name: (routeData) {
      final args = routeData.argsAs<SubscriptionPageRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.SubscriptionPage(
          key: args.key,
          isSubscribing: args.isSubscribing,
        ),
      );
    },
    UserProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfilePageRouteArgs>();
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.UserProfilePage(
          key: args.key,
          isGroup: args.isGroup,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddUserPage]
class AddUserPageRoute extends _i24.PageRouteInfo<AddUserPageRouteArgs> {
  AddUserPageRoute({
    _i25.Key? key,
    dynamic Function()? onTap,
    required bool isAdding,
    bool? isAddingInfo,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          AddUserPageRoute.name,
          args: AddUserPageRouteArgs(
            key: key,
            onTap: onTap,
            isAdding: isAdding,
            isAddingInfo: isAddingInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'AddUserPageRoute';

  static const _i24.PageInfo<AddUserPageRouteArgs> page =
      _i24.PageInfo<AddUserPageRouteArgs>(name);
}

class AddUserPageRouteArgs {
  const AddUserPageRouteArgs({
    this.key,
    this.onTap,
    required this.isAdding,
    this.isAddingInfo,
  });

  final _i25.Key? key;

  final dynamic Function()? onTap;

  final bool isAdding;

  final bool? isAddingInfo;

  @override
  String toString() {
    return 'AddUserPageRouteArgs{key: $key, onTap: $onTap, isAdding: $isAdding, isAddingInfo: $isAddingInfo}';
  }
}

/// generated route for
/// [_i2.BlockUserPage]
class BlockUserPageRoute extends _i24.PageRouteInfo<void> {
  const BlockUserPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          BlockUserPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlockUserPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatPage]
class ChatPageRoute extends _i24.PageRouteInfo<void> {
  const ChatPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ChatPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChatRoomPage]
class ChatRoomPageRoute extends _i24.PageRouteInfo<void> {
  const ChatRoomPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ChatRoomPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoomPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CreateGroup]
class CreateGroupRoute extends _i24.PageRouteInfo<CreateGroupRouteArgs> {
  CreateGroupRoute({
    _i25.Key? key,
    required bool isRoom,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          CreateGroupRoute.name,
          args: CreateGroupRouteArgs(
            key: key,
            isRoom: isRoom,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateGroupRoute';

  static const _i24.PageInfo<CreateGroupRouteArgs> page =
      _i24.PageInfo<CreateGroupRouteArgs>(name);
}

class CreateGroupRouteArgs {
  const CreateGroupRouteArgs({
    this.key,
    required this.isRoom,
  });

  final _i25.Key? key;

  final bool isRoom;

  @override
  String toString() {
    return 'CreateGroupRouteArgs{key: $key, isRoom: $isRoom}';
  }
}

/// generated route for
/// [_i6.DataPreviewPage]
class DataPreviewPageRoute
    extends _i24.PageRouteInfo<DataPreviewPageRouteArgs> {
  DataPreviewPageRoute({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          DataPreviewPageRoute.name,
          args: DataPreviewPageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DataPreviewPageRoute';

  static const _i24.PageInfo<DataPreviewPageRouteArgs> page =
      _i24.PageInfo<DataPreviewPageRouteArgs>(name);
}

class DataPreviewPageRouteArgs {
  const DataPreviewPageRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'DataPreviewPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.EditProfilePage]
class EditProfilePageRoute extends _i24.PageRouteInfo<void> {
  const EditProfilePageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          EditProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfilePageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FilePreviewPage]
class FilePreviewPageRoute extends _i24.PageRouteInfo<void> {
  const FilePreviewPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          FilePreviewPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilePreviewPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i9.FileViewerPage]
class FileViewerPageRoute extends _i24.PageRouteInfo<void> {
  const FileViewerPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          FileViewerPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'FileViewerPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i24.PageRouteInfo<void> {
  const ForgotPasswordPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ForgotPasswordPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i11.GalleryPage]
class GalleryPageRoute extends _i24.PageRouteInfo<GalleryPageRouteArgs> {
  GalleryPageRoute({
    _i25.Key? key,
    required _i26.MediumType type,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          GalleryPageRoute.name,
          args: GalleryPageRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'GalleryPageRoute';

  static const _i24.PageInfo<GalleryPageRouteArgs> page =
      _i24.PageInfo<GalleryPageRouteArgs>(name);
}

class GalleryPageRouteArgs {
  const GalleryPageRouteArgs({
    this.key,
    required this.type,
  });

  final _i25.Key? key;

  final _i26.MediumType type;

  @override
  String toString() {
    return 'GalleryPageRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i12.GetStartedPage]
class GetStartedPageRoute extends _i24.PageRouteInfo<void> {
  const GetStartedPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          GetStartedPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i13.GroupInfoPage]
class GroupInfoPageRoute extends _i24.PageRouteInfo<void> {
  const GroupInfoPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          GroupInfoPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupInfoPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i14.GroupList]
class GroupListRoute extends _i24.PageRouteInfo<GroupListRouteArgs> {
  GroupListRoute({
    _i25.Key? key,
    required String title,
    required bool premium,
    required _i27.GroupCategory category,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          GroupListRoute.name,
          args: GroupListRouteArgs(
            key: key,
            title: title,
            premium: premium,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'GroupListRoute';

  static const _i24.PageInfo<GroupListRouteArgs> page =
      _i24.PageInfo<GroupListRouteArgs>(name);
}

class GroupListRouteArgs {
  const GroupListRouteArgs({
    this.key,
    required this.title,
    required this.premium,
    required this.category,
  });

  final _i25.Key? key;

  final String title;

  final bool premium;

  final _i27.GroupCategory category;

  @override
  String toString() {
    return 'GroupListRouteArgs{key: $key, title: $title, premium: $premium, category: $category}';
  }
}

/// generated route for
/// [_i15.HomeBottomBar]
class HomeBottomBarRoute extends _i24.PageRouteInfo<void> {
  const HomeBottomBarRoute({List<_i24.PageRouteInfo>? children})
      : super(
          HomeBottomBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeBottomBarRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i16.InternetDataPreviewPage]
class InternetDataPreviewPageRoute
    extends _i24.PageRouteInfo<InternetDataPreviewPageRouteArgs> {
  InternetDataPreviewPageRoute({
    _i25.Key? key,
    required String url,
    required _i28.MessageType type,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          InternetDataPreviewPageRoute.name,
          args: InternetDataPreviewPageRouteArgs(
            key: key,
            url: url,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'InternetDataPreviewPageRoute';

  static const _i24.PageInfo<InternetDataPreviewPageRouteArgs> page =
      _i24.PageInfo<InternetDataPreviewPageRouteArgs>(name);
}

class InternetDataPreviewPageRouteArgs {
  const InternetDataPreviewPageRouteArgs({
    this.key,
    required this.url,
    required this.type,
  });

  final _i25.Key? key;

  final String url;

  final _i28.MessageType type;

  @override
  String toString() {
    return 'InternetDataPreviewPageRouteArgs{key: $key, url: $url, type: $type}';
  }
}

/// generated route for
/// [_i17.LoginPage]
class LoginPageRoute extends _i24.PageRouteInfo<void> {
  const LoginPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i18.OtpPage]
class OtpPageRoute extends _i24.PageRouteInfo<OtpPageRouteArgs> {
  OtpPageRoute({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          OtpPageRoute.name,
          args: OtpPageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'OtpPageRoute';

  static const _i24.PageInfo<OtpPageRouteArgs> page =
      _i24.PageInfo<OtpPageRouteArgs>(name);
}

class OtpPageRouteArgs {
  const OtpPageRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'OtpPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.PrivateChatPage]
class PrivateChatPageRoute extends _i24.PageRouteInfo<void> {
  const PrivateChatPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          PrivateChatPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateChatPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i20.SignUpPage]
class SignUpPageRoute extends _i24.PageRouteInfo<void> {
  const SignUpPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SignUpPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i21.SplashPage]
class SplashPageRoute extends _i24.PageRouteInfo<void> {
  const SplashPageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SplashPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashPageRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i22.SubscriptionPage]
class SubscriptionPageRoute
    extends _i24.PageRouteInfo<SubscriptionPageRouteArgs> {
  SubscriptionPageRoute({
    _i25.Key? key,
    required bool isSubscribing,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          SubscriptionPageRoute.name,
          args: SubscriptionPageRouteArgs(
            key: key,
            isSubscribing: isSubscribing,
          ),
          initialChildren: children,
        );

  static const String name = 'SubscriptionPageRoute';

  static const _i24.PageInfo<SubscriptionPageRouteArgs> page =
      _i24.PageInfo<SubscriptionPageRouteArgs>(name);
}

class SubscriptionPageRouteArgs {
  const SubscriptionPageRouteArgs({
    this.key,
    required this.isSubscribing,
  });

  final _i25.Key? key;

  final bool isSubscribing;

  @override
  String toString() {
    return 'SubscriptionPageRouteArgs{key: $key, isSubscribing: $isSubscribing}';
  }
}

/// generated route for
/// [_i23.UserProfilePage]
class UserProfilePageRoute
    extends _i24.PageRouteInfo<UserProfilePageRouteArgs> {
  UserProfilePageRoute({
    _i25.Key? key,
    required bool isGroup,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          UserProfilePageRoute.name,
          args: UserProfilePageRouteArgs(
            key: key,
            isGroup: isGroup,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfilePageRoute';

  static const _i24.PageInfo<UserProfilePageRouteArgs> page =
      _i24.PageInfo<UserProfilePageRouteArgs>(name);
}

class UserProfilePageRouteArgs {
  const UserProfilePageRouteArgs({
    this.key,
    required this.isGroup,
  });

  final _i25.Key? key;

  final bool isGroup;

  @override
  String toString() {
    return 'UserProfilePageRouteArgs{key: $key, isGroup: $isGroup}';
  }
}
