part of 'routes_imports.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends $AppRouter {
  AppRouter({super.navigatorKey});
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<CustomRoute> get routes => [
        CustomRoute(
            page: SplashPageRoute.page,
            initial: true,
            path: '/',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: GetStartedPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: LoginPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: SignUpPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: OtpPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: PrivateChatPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ChatPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ChatRoomPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: GroupInfoPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: UserProfilePageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: SubscriptionPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: HomeBottomBarRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: AddUserPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CreateGroupRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: EditProfilePageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: DataPreviewPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.slideBottom),
        CustomRoute(
            page: InternetDataPreviewPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.slideBottom),
        CustomRoute(
            page: GroupListRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ForgotPasswordPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
          CustomRoute(
            page: BlockUserPageRoute.page,
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: GalleryPageRoute.page,
        durationInMilliseconds: 200,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: FileViewerPageRoute.page,
        durationInMilliseconds: 200,
        transitionsBuilder: TransitionsBuilders.fadeIn),
            CustomRoute(
        page: FilePreviewPageRoute.page,
        durationInMilliseconds: 200,
        transitionsBuilder: TransitionsBuilders.fadeIn),
      ];
}
