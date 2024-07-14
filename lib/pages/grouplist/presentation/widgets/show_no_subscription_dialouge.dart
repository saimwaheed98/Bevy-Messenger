import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/widgets/gesture_container.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes_imports.gr.dart';
import '../../../../utils/colors.dart';

class NoSubscription extends StatelessWidget {
  final String? title;
  final bool? isSubscribing;
  const NoSubscription({
    super.key, this.title, this.isSubscribing,
  });

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
             AppTextStyle(
                text:
                    title ??  "This chat room is premium if you want to join \nPlease subscribe to the premium plan",
                fontSize: 18,
                fontWeight: FontWeight.w500),
            const SizedBox(
              height: 20,
            ),
            GestureContainer(
                onPressed: () async {
                  Navigator.of(context).pop();
                  AutoRouter.of(context).push(  SubscriptionPageRoute(
                    isSubscribing: isSubscribing ?? false
                  ));
                },
                buttonText: "Yes",
                heroTag: ""),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
