
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/grouplist/presentation/widgets/my_rooms_list.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';

import '../../../../bloc/cubits/auth_cubit.dart';

@RoutePage()
class GroupList extends StatelessWidget {
  final String title;
  final bool premium;
  final GroupCategory category;
  const GroupList({super.key, required this.title, required this.premium, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    )),
                const Spacer(),
                AppTextStyle(
                    text: title,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
             MyRoomList(
              category: category,
               premium: premium,
            ),
          ],
        ),
      )),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
