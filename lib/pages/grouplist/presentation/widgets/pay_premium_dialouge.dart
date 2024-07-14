import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/widgets/custom_button.dart';
import 'package:bevy_messenger/widgets/gesture_container.dart';
import 'package:flutter/material.dart';

import '../../../../data/datasources/auth_datasource.dart';
import '../../../../helper/toast_messages.dart';
import '../../../../routes/routes_imports.gr.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/enums.dart';

class PremiumGroupDialouge extends StatelessWidget {
  final GroupModel groupData;
  final String subscriptionId;
  const PremiumGroupDialouge(
      {super.key, required this.groupData, required this.subscriptionId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.textSecColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppTextStyle(
                text: "Warning!", fontSize: 24, fontWeight: FontWeight.w300),
            const SizedBox(
              height: 8,
            ),
            const AppTextStyle(
                text: "This chat room is for 18 and \nOlder only",
                fontSize: 18,
                fontWeight: FontWeight.w500),
            const SizedBox(
              height: 20,
            ),
            GestureContainer(
                onPressed: () async {
                  if(!groupData.blockedUsers.contains(_authCubit.userData.id)) {
                    _authCubit.removeSubscriptionList(subscriptionId);
                    await AuthDataSource.addTheGroupToUserSubscription(
                        groupData.id, groupData.name, subscriptionId);
                    AutoRouter.of(context).pop();
                    _getUserDataCubit.setChatStatus(ChatStatus.group);
                    _getUserDataCubit.getGroupData(groupData);
                    AutoRouter.of(context).push(const ChatPageRoute());
                  }else{
                    WarningHelper.showWarningToast("You are bloc for this chat room you cannot enter in it", context);
                  }
                },
                buttonText: "Yes i am 18",
                heroTag: ""),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPressed: () {
                  AutoRouter.of(context).pop();
                },
                buttonText: "No",
                heroTag: "")
          ],
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
