import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';

class RecentSearchContainer extends StatelessWidget {
  final String name;
   RecentSearchContainer({super.key, required this.name});
  final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: InkWell(
        onTap: (){
          _getUserCubit.addValueInController(name);
          _getUserCubit.searchUsers(name);
        },
        child: Container(
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                    color: AppColors.black.withOpacity(0.36),
                    blurRadius: 16,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xff121A1A),
                    const Color(0xff121A1A).withOpacity(0.66),
                  ])),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextStyle(
                  text: name,
                  fontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: (){
                  _getUserCubit.removeSearchQuery(name);
                },
                child: const Icon(
                  Icons.cancel,
                  color: AppColors.secRedColor,
                  size: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
