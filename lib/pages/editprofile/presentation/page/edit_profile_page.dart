
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:bevy_messenger/widgets/custom_button.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/editer_container.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController country = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController city = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  // get the user data from the cubit
  final AuthCubit _authCubit = Di().sl<AuthCubit>();

  @override
  void initState() {
    nameController.text = _authCubit.userData.name;
    emailController.text = _authCubit.userData.email;
    addressController.text = _authCubit.userData.address;
    phoneController.text = _authCubit.userData.phone;
    country.text = _authCubit.userData.country;
    stateController.text = _authCubit.userData.state;
    city.text = _authCubit.userData.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authCubit,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.textSecColor,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                    ),
                    const Spacer(),
                    const AppTextStyle(
                        text: "Edit Info",
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    const Spacer(),
                    const SizedBox(
                      width: 58,
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                EditerContainer(
                  editText: "Display name",
                  controller: nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                EditerContainer(
                  editText: "Email Address",
                  controller: emailController,
                  isReadOnly: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                EditerContainer(
                  editText: "Phone Number",
                  controller: phoneController,
                  isReadOnly: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CSCPicker(
                  showStates: true,
                  layout: Layout.vertical,
                  showCities: true,
                  flagState: CountryFlag.DISABLE,
                  dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColors.black.withOpacity(0.25),),
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColors.black.withOpacity(0.25),
                      ),
                  countrySearchPlaceholder: "Country",
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",
                  countryDropdownLabel: "Country",
                  stateDropdownLabel: "State",
                  cityDropdownLabel: "City",
                  selectedItemStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  dropdownHeadingStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                  dropdownItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownDialogRadius: 10.0,
                  searchBarRadius: 10.0,
                  onCountryChanged: (value) {
                    setState(() {
                      country.text = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateController.text = value ?? "";
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      city.text = value ?? "";
                    });
                  },
                ),
              ],
            ),
          )),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                onPressed: () {
                  _authCubit.updateUserInfo(nameController.text,
                      phoneController.text,
                      country.text,
                      city.text,
                      stateController.text,
                      context);
                },
                buttonText: "Save Info",
                heroTag: ""),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
