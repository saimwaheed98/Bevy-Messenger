part of 'service_locator_imports.dart';

class Di {
  final sl = GetIt.I;
  Future<void> setup() async {
    // clients
    sl.registerLazySingleton<Dio>(
      () => Dio(baseOptions()),
    );

    // services
    sl.registerLazySingleton<NotificationHelper>(
      () => NotificationHelperImpl(sl()),
    );
    sl.registerLazySingleton<SendNotificationCubit>(
      () => SendNotificationCubit(sl()),
    );
    
    // cubits
    sl.registerFactory<ValidateTextFieldsCubit>(
        () => ValidateTextFieldsCubit());
    sl.registerLazySingleton<BottomBarCubit>(() => BottomBarCubit());
    sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
    sl.registerLazySingleton<CheckAppUpdateCubit>(
        () => CheckAppUpdateCubit(sl()));
    sl.registerLazySingleton<InternetConCubit>(() => InternetConCubit(sl()));
    sl.registerLazySingleton<GetNotificationClickCubit>(
        () => GetNotificationClickCubit(sl()));
    sl.registerLazySingleton<CreateProfileCubit>(
        () => CreateProfileCubit(sl()));
    sl.registerLazySingleton<VerifyOtpCreateProfileCubit>(
        () => VerifyOtpCreateProfileCubit(sl()));
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit(sl()));
    sl.registerLazySingleton(() => ResendOtpCubit(sl()));
    sl.registerLazySingleton<GetPrivateChatCubit>(
        () => GetPrivateChatCubit(sl()));
    sl.registerLazySingleton<OtherUserDataCubit>(() => OtherUserDataCubit());
    sl.registerLazySingleton<AddChatUsersCubit>(() => AddChatUsersCubit());
    sl.registerLazySingleton<PickImage>(() => PickImage());
    sl.registerLazySingleton<GetUserDataCubit>(() => GetUserDataCubit());
    sl.registerLazySingleton<SendMessageCubit>(() => SendMessageCubit(sl()));
    sl.registerLazySingleton<GetMessagesCubit>(() => GetMessagesCubit(sl()));
    sl.registerLazySingleton<GetUserCubit>(() => GetUserCubit());
    sl.registerLazySingleton<CreateGroupCubit>(() => CreateGroupCubit(sl()));
    sl.registerLazySingleton<GetGroupsCubit>(() => GetGroupsCubit(sl()));
    sl.registerLazySingleton<SendGroupMessageCubit>(
        () => SendGroupMessageCubit(sl()));
    sl.registerLazySingleton<UpdateUserGroupOnlineCubit>(
        () => UpdateUserGroupOnlineCubit(sl()));
    sl.registerLazySingleton<SendFileMessageCubit>(
        () => SendFileMessageCubit(sl()));
    sl.registerLazySingleton<SendGroupFileMessageCubit>(
        () => SendGroupFileMessageCubit(sl()));
    sl.registerLazySingleton<PaymentCubit>(() => PaymentCubit(sl()));
    sl.registerLazySingleton<RemoveUserGroupCubit>(
        () => RemoveUserGroupCubit());
    sl.registerLazySingleton<GalleryCubit>(() => GalleryCubit());

    // data sources
    sl.registerLazySingleton<CheckUpdateDataSource>(
        () => CheckUpdateDataSourceImpl());
    sl.registerLazySingleton<InternetConnectionDataSource>(
        () => InternetConnectionDataSourceImpl());
    sl.registerLazySingleton<CheckNotificationClickDataSource>(
        () => CheckNotificationClickDataSourceImpl());
    sl.registerLazySingleton<CreateProfileDataSource>(
        () => CreateProfileDataSourceImpl());
    sl.registerLazySingleton<VerifyOtpDataSource>(
        () => VerifyOtpDataSourceImpl());
    sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl());
    sl.registerLazySingleton<ResendOtpDataSource>(
        () => ResendOtpDataSourceImpl());
    sl.registerLazySingleton<GetPrivateChatRoomsDataSource>(
        () => GetPrivateChatRoomsDataSourceImpl());
    sl.registerLazySingleton<ImagePickerCubit>(() => ImagePickerCubit(sl()));
    sl.registerLazySingleton<SendMessageDataSource>(
        () => SendMessageDataSourceImpl());
    sl.registerLazySingleton<GetMessagesDataSource>(
        () => GetMessagesDataSourceImpl());
    sl.registerLazySingleton<CreateGroupDataSource>(
        () => CreateGroupDataSourceImpl());
    sl.registerLazySingleton<GetGroupsDataSource>(
        () => GetGroupsDataSourceImpl());
    sl.registerLazySingleton<SendMessageGroupDataSource>(
        () => SendMessageGroupDataSourceImpl());
    sl.registerLazySingleton<UpdateGroupUserOnlineDataSource>(
        () => UpdateGroupUserOnlineDataSourceImpl());
    sl.registerLazySingleton<SendFileMessageDataSource>(
        () => SendFileMessageDataSourceImpl());
    sl.registerLazySingleton<SendGroupFileMessageDataSource>(
        () => SendGroupFileMessageDataSourceImpl());
    sl.registerLazySingleton<PaymentDataSource>(() => PaymentDataSource());

    // usecases
    sl.registerLazySingleton<CreateProfileUsecase>(
        () => CreateProfileUsecase(sl()));
    sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl()));
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
    sl.registerLazySingleton<ResendOtpUseCase>(() => ResendOtpUseCase(sl()));
    sl.registerLazySingleton<GetPrivateChatUseCase>(
        () => GetPrivateChatUseCase(sl()));
    sl.registerLazySingleton<SendMessageUseCase>(
        () => SendMessageUseCase(sl()));
    sl.registerLazySingleton<GetMessagesUseCase>(
        () => GetMessagesUseCase(sl()));
    sl.registerLazySingleton<CreateGroupUseCase>(
        () => CreateGroupUseCase(sl()));
    sl.registerLazySingleton<GetGroupsUseCase>(() => GetGroupsUseCase(sl()));
    sl.registerLazySingleton<SendMessageGroupUseCase>(
        () => SendMessageGroupUseCase(sl()));
    sl.registerLazySingleton<UpdateUserGroupOnlineUseCase>(
        () => UpdateUserGroupOnlineUseCase(sl()));
    sl.registerLazySingleton<SendFileMessageUseCase>(
        () => SendFileMessageUseCase(sl()));
    sl.registerLazySingleton<SendGroupFileMessageUseCase>(
        () => SendGroupFileMessageUseCase(sl()));

    // repositories
    sl.registerLazySingleton<CreateProfileRepository>(
        () => CreateProfileRepositoryImpl(sl()));
    sl.registerLazySingleton<VerifyOtpRepository>(
        () => VerifyOtpRepositoryImpl(sl()));
    sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
    sl.registerLazySingleton<ResendOtpRepository>(
        () => ResendOtpRepositoryImpl(sl()));
    sl.registerLazySingleton<GetPrivateChatRepository>(
        () => GetPrivateChatRepositoryImpl(sl()));
    sl.registerLazySingleton<SendMessageRepository>(
        () => SendMessageRepositoryImpl(sl()));
    sl.registerLazySingleton<GetMessagesRepository>(
        () => GetMessagesRepositoryImpl(sl()));
    sl.registerLazySingleton<CreateGroupRepository>(
        () => CreateGroupRepositoryImpl(sl()));
    sl.registerLazySingleton<GetGroupsRepository>(
        () => GetGroupsRepositoryImp(sl()));
    sl.registerLazySingleton<SendMessagesGroupRepository>(
        () => SendMessageGroupRepositoryImpl(sl()));
    sl.registerLazySingleton<UpdateGroupUserOnlineRepository>(
        () => UpdateGroupUserOnlineRepositoryImpl(sl()));
    sl.registerLazySingleton<SendFileMessageRepository>(
        () => SendFileMessageRepositoryImpl(sl()));
    sl.registerLazySingleton<SendGroupFileMessageRepository>(
        () => SendGroupFileMessageRepositoryImpl(sl()));
  }
}
