import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_text_style.dart';

class BlockUserContainer extends StatelessWidget {
  const BlockUserContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: (){
        AutoRouter.of(context).push(const BlockUserPageRoute());
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.textColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextStyle(
                text: "Blocked user",
                fontSize: 24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500),
           Icon(Icons.block,color: AppColors.containerBg,),
            
          ],
        ),
      ),
    );
  }
}