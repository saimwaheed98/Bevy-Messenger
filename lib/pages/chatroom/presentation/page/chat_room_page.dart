import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/widgets/groups_list.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/widgets/room_list.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/widgets/search_field.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/cubits/auth_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/colors.dart';

@RoutePage()
class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const AppTextStyle(
                  text: 'Chat Rooms',
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 21,
              ),
              Row(
                children: [
                  Expanded(child: SearchField()),
                  const SizedBox(
                    width: 15,
                  ),
                  if (_authCubit.userData.email == "admin@ourbevy.com")
                    GestureDetector(
                      onTap: () {
                        _createGroupCubit
                            .changeGroupCategory(GroupCategory.room);
                        AutoRouter.of(context)
                            .push(CreateGroupRoute(isRoom: true));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.add, color: AppColors.white),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              BlocBuilder(
                bloc: _getGroupsCubit,
                builder: (context, state) {
                  return _getGroupsCubit.isSearchingGroups == false
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [RoomList()],
                        )
                      : const SizedBox();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (_authCubit.userData.email == "admin@ourbevy.com")
                StreamBuilder(
                    stream: AuthDataSource.firestore
                        .collection("groups")
                        .snapshots(),
                    builder: (context, snapshot) {
                      var data = snapshot.data?.docs;
                      var list = data
                          ?.map((e) => GroupModel.fromJson(e.data()))
                          .toList();
                      var filterdList = list
                          ?.where((element) =>
                              element.category == GroupCategory.room.name)
                          .toList();
                      return AppTextStyle(
                          text: filterdList?.isNotEmpty ?? false
                              ? 'There Are ( ${filterdList?.length} ) Chat Rooms'
                              : "",
                          fontSize: 12,
                          fontWeight: FontWeight.w400);
                    }),
              if (_authCubit.userData.email != "admin@ourbevy.com")
                AppTextStyle(
                    text: _getGroupsCubit.premiumGroups.isNotEmpty
                        ? 'There Are ( ${_getGroupsCubit.premiumGroups.length} ) Chat Rooms'
                        : "",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              const SizedBox(
                height: 18,
              ),
              const GroupsList(
                premium: true,
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final GetGroupsCubit _getGroupsCubit = Di().sl<GetGroupsCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
