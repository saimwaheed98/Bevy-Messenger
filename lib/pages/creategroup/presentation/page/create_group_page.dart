import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/widgets/add_description.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/widgets/setting_list.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:bevy_messenger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/participiant_list.dart';

@RoutePage()
class CreateGroup extends StatelessWidget {
  final bool isRoom;
  const CreateGroup({super.key,required this.isRoom});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        _imagePickerCubit.image = null;
        _createGroupCubit.premiumGroup = false;
        _createGroupCubit.emptyParticipants();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.textSecColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                              color: AppColors.containerBg,
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () {
                                _imagePickerCubit.image = null;
                                _createGroupCubit.premiumGroup = false;
                                _createGroupCubit.emptyParticipants();
                                AutoRouter.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.white,
                                size: 18,
                              )),
                        ),
                        const Spacer(),
                        AppTextStyle(
                            text: isRoom ? 'Create Chat Room' : "Create Group",
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        const Spacer(),
                        const SizedBox(
                          width: 48,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    BlocBuilder(
                      bloc: _imagePickerCubit,
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            _imagePickerCubit.pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 115,
                            width: 115,
                            decoration: BoxDecoration(
                                color: AppColors.containerBg,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                        _imagePickerCubit.image ?? File(""))),
                                borderRadius: BorderRadius.circular(100)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppImages.pictureIcon),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    BlocBuilder(
                      bloc: _createGroupCubit,
                      builder: (context, state) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            controller: _createGroupCubit.nameController,
                            style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                                maxWidth: 186
                              ),
                              fillColor: AppColors.fieldsColor,
                              filled: true,
                              hintText: isRoom ? 'Add Chat Room Name' : "Add Group Name",
                              hintStyle: const TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AddDescription(
                      isRoom : isRoom
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if(_authCubit.userData.email == "admin@ourbevy.com" && _createGroupCubit.groupCategory == GroupCategory.room)
                    GroupCreationSettingList(
                      isRoom: isRoom,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if(_authCubit.userData.email != "admin@ourbevy.com" || _createGroupCubit.participants.isNotEmpty)
                    BlocBuilder(
                      bloc: _createGroupCubit,
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppTextStyle(
                                text: 'Participants',
                                fontSize: 14,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w700),
                            InkWell(
                              onTap: () {
                                AutoRouter.of(context).push(AddUserPageRoute(
                                  onTap: () {
                                    log("adatdatda false");
                                  },
                                  isAdding: true,
                                ));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.redColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.add,
                                    color: AppColors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Column(
                      children: [
                        ParticipiantList(),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
          ),
        ),
        floatingActionButton: BlocBuilder(
          bloc: _createGroupCubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  isLoading: _createGroupCubit.isCreatingGroup,
                  onPressed: () {
                    _createGroupCubit.createGroup(context,isRoom);
                  },
                  buttonText: isRoom ? "Create Chat Room" : "Create Group",
                  heroTag: ""),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();