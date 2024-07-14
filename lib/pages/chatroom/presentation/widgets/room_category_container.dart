import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoomCategoryContainer extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool isNeedIcon;
  const RoomCategoryContainer(
      {super.key, this.onTap, required this.title, required this.isNeedIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85,
        width: 95,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  blurRadius: 38,
                  blurStyle: BlurStyle.outer,
                  color: AppColors.black.withOpacity(0.45))
            ],
            color: const Color(0xff3D3C3C)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextStyle(
                text: title,
                fontSize: 15,
                maxLines: 3,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400),
            const SizedBox(
              height: 5,
            ),
            if (isNeedIcon)
              SvgPicture.asset(
                AppImages.subscriptionIcon,
                height: 16,
                width: 16,
              )
          ],
        ),
      ),
    );
  }
}
