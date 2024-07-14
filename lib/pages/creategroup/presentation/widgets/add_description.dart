import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../bloc/cubit/create_group_cubit.dart';

class AddDescription extends StatelessWidget {
  final bool isRoom;
  const AddDescription({super.key, required this.isRoom});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _createGroupCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextStyle(
                text: isRoom ? 'Chat Room Description' : "Group Description (Optional)",
                fontSize: 16,
                fontWeight: FontWeight.w700),
            const SizedBox(
              height: 6,
            ),
            Container(
                height: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.fieldsColor),
                child: TextFormField(
                  controller: _createGroupCubit.descriptionController,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    hintText: 'Add A Description',
                    hintStyle: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                )),
          ],
        );
      },
    );
  }
}

final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();