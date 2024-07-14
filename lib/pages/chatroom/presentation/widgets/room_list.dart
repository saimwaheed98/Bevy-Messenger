import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/widgets/room_category_container.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes_imports.gr.dart';
import '../../../../utils/enums.dart';

class RoomList extends StatelessWidget {
  const RoomList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // if(_authCubit.userData.email = "admin@ourbevy.com")
              RoomCategoryContainer(
            onTap: () {
              AutoRouter.of(context).push(GroupListRoute(
                premium: true,
                category: GroupCategory.room,
                title: "Premium Chat Rooms",
              ));
            },
            title: "Premium\nChat\nRooms",
            isNeedIcon: false),
        const SizedBox(width: 16),
        RoomCategoryContainer(
            onTap: () {
              AutoRouter.of(context).push(GroupListRoute(
                premium: false,
                category: GroupCategory.room,
                title: "Free Chat Rooms",
              ));
            },
            title: "Free\nChat\nRooms",
            isNeedIcon: false),
      ],
    );
  }
}
