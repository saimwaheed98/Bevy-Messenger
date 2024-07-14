import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearchField extends StatelessWidget {
  UserSearchField({super.key});

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white));

  final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _getUserCubit,
      builder: (context, state) {
        return TextFormField(
          controller: _getUserCubit.searchController,
          onChanged: (value) {
            _getUserCubit.searchUsers(value);
          },
          onFieldSubmitted: (value) async {
            _getUserCubit.saveSearch(value);
          },
          style: const TextStyle(
              color: Colors.grey,
              fontFamily: 'dmSans',
              fontSize: 14,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              constraints: const BoxConstraints(maxHeight: 44),
              hintText: 'Search...',
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'dmSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_getUserCubit.isSearching) {
                    _getUserCubit.cancelSearch();
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xff565E70),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    _getUserCubit.isSearching ? Icons.cancel : Icons.search,
                    color: _getUserCubit.isSearching
                        ? AppColors.secRedColor
                        : AppColors.white,
                  ),
                ),
              ),
              filled: true,
              fillColor: AppColors.fieldsColor,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        );
      },
    );
  }
}
