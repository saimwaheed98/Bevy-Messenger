import 'package:bevy_messenger/pages/chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white));

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _getGroupsCubit,
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          onChanged: (value) {
            _getGroupsCubit.searchGroups(value);
          },
          style: const TextStyle(
              color: Colors.grey,
              fontFamily: 'dmSans',
              fontSize: 14,
              fontWeight: FontWeight.w600),
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
                  if (_getGroupsCubit.isSearchingGroups) {
                    _controller.clear();
                    _getGroupsCubit.cancelSearch();
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.containerBorder,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    _getGroupsCubit.isSearchingGroups
                        ? Icons.cancel
                        : Icons.search,
                    color: _getGroupsCubit.isSearchingGroups
                        ? AppColors.secRedColor
                        : AppColors.white,
                    size: _getGroupsCubit.isSearchingGroups ? 20 : 24,
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

final GetGroupsCubit _getGroupsCubit = Di().sl<GetGroupsCubit>();
