import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/cubits/auth_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/screen_sizes.dart';
import '../bloc/cubit/other_user_data_cubit.dart';

class UserBottomSheet extends StatefulWidget {
  const UserBottomSheet({super.key});

  @override
  State<UserBottomSheet> createState() => _UserBottomSheetState();
}

class _UserBottomSheetState extends State<UserBottomSheet> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: DraggableScrollableSheet(
            initialChildSize: isExpanded ? 0.8 : 0.4,
            maxChildSize: 0.8,
            minChildSize: 0.4,
            expand: false,
            builder: (context, scrollController) {
              return Container(
                width: getWidth(context),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: const BoxDecoration(
                  color: Color(0xff595C65),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(27),
                    topRight: Radius.circular(27),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        child: Icon(
                          Icons.horizontal_rule,
                          color: AppColors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AppTextStyle(
                        text: 'Display Name',
                        fontSize: 14,
                        color: Color(0xff797C7B),
                        fontWeight: FontWeight.w700,
                      ),
                      AppTextStyle(
                        text: _otherUserDataCubit.userData != null
                            ? _otherUserDataCubit.userData?.name ?? ''
                            : _authCubit.userData.name,
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 30),
                      const AppTextStyle(
                        text: 'Email Address',
                        fontSize: 14,
                        color: Color(0xff797C7B),
                        fontWeight: FontWeight.w700,
                      ),
                      AppTextStyle(
                        text: _otherUserDataCubit.userData != null
                            ? _otherUserDataCubit.userData?.email ?? ''
                            : _authCubit.userData.email,
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 30),
                      const AppTextStyle(
                        text: 'Country',
                        fontSize: 14,
                        color: Color(0xff797C7B),
                        fontWeight: FontWeight.w700,
                      ),
                      AppTextStyle(
                        text: _otherUserDataCubit.userData != null
                            ? _otherUserDataCubit.userData?.country ?? ''
                            : _authCubit.userData.country,
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 30),
                      const AppTextStyle(
                        text: 'State',
                        fontSize: 14,
                        color: Color(0xff797C7B),
                        fontWeight: FontWeight.w700,
                      ),
                      AppTextStyle(
                        text: _otherUserDataCubit.userData != null
                            ? _otherUserDataCubit.userData?.state ?? ''
                            : _authCubit.userData.state,
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 30),
                      const AppTextStyle(
                        text: 'City',
                        fontSize: 14,
                        color: Color(0xff797C7B),
                        fontWeight: FontWeight.w700,
                      ),
                      AppTextStyle(
                        text: _otherUserDataCubit.userData != null
                            ? _otherUserDataCubit.userData?.city ?? ''
                            : _authCubit.userData.city,
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: _otherUserDataCubit.userData == null
                            ? getHeight(context) * 0.15
                            : getHeight(context) * 0.10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
