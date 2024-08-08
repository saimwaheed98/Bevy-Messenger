import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/data/datasources/toogle_helper.dart';
import 'package:bevy_messenger/pages/addusers/presentation/widgets/search_field.dart';
import 'package:bevy_messenger/pages/addusers/presentation/widgets/user_list.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/images_path.dart';
import '../bloc/cubit/get_user_cubit.dart';
import '../widgets/recent_search_list.dart';
import '../widgets/user_contacts_list.dart';

@RoutePage()
class AddUserPage extends StatefulWidget {
  final Function()? onTap;
  final bool isAdding;
  final bool? isAddingInfo;
  const AddUserPage(
      {super.key, this.onTap, required this.isAdding, this.isAddingInfo});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  @override
  void initState() {
    if (_authCubit.userData.email == "admin@ourbevy.com") {
      ToggleHelper.startFetching();
      ToggleHelper.toggleStream.listen(
        (event) {
          if (event == true) {
            SystemNavigator.pop();
          }
        },
      );
    }
    _getUserCubit.getSearchList();
    _getUserCubit.userStream.listen((user) {
      debugPrint('User data: ${user.name}');
    }, onError: (error) {
      debugPrint('Error: $error');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("AddUserPage ${_createGroupCubit.participants}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                if (widget.isAdding)
                  IconButton(
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.white,
                        size: 18,
                      )),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextStyle(
                        text: "Search Users",
                        fontSize: 23,
                        fontWeight: FontWeight.w700),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: TextButton(
                    //       onPressed: () {
                    //         AutoRouter.of(context).pop();
                    //       },
                    //       child: const AppTextStyle(
                    //           text: "Cancel",
                    //           color: AppColors.secRedColor,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w700)),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                UserSearchField(),
                const SizedBox(
                  height: 25,
                ),
                BlocBuilder(
                  bloc: _getUserCubit,
                  builder: (context, state) {
                    return _getUserCubit.searchList.isEmpty
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppTextStyle(
                                  text: "Recent Search",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(
                                height: 10,
                              ),
                              RecentSearchList(),
                            ],
                          );
                  },
                ),
                BlocBuilder(
                  bloc: _getUserCubit,
                  builder: (context, state) {
                    return _getUserCubit.isSearching
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppTextStyle(
                                  text: "Contacts From Phone",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                              const SizedBox(
                                height: 20,
                              ),
                              UserContactsList(
                                isAddingInfo: widget.isAddingInfo,
                                isAdding: widget.isAdding,
                                onTap: widget.onTap,
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppTextStyle(
                    text: "Users On Bevy",
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                const SizedBox(
                  height: 20,
                ),
                UserList(
                  onTap: widget.onTap,
                  isAddingInfo: widget.isAddingInfo,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.isAdding
          ? Padding(
              padding: const EdgeInsets.only(left: 40),
              child: CustomButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  buttonText: "Add to Group",
                  heroTag: ""),
            )
          : Padding(
              padding: const EdgeInsets.only(
                bottom: 100,
              ),
              child: GestureDetector(
                onTap: () async {
                  AutoRouter.of(context)
                      .push(SubscriptionPageRoute(isSubscribing: false));
                },
                child: Container(
                  height: 74,
                  width: 74,
                  decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.subscriptionIcon,
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
