import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:bevy_messenger/pages/addusers/presentation/widgets/recent_search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchList extends StatelessWidget {
   RecentSearchList({super.key});

  final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _getUserCubit,
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 50, maxHeight: 200,minWidth: 100),
            child: ListView.builder(
              itemCount:_getUserCubit.searchList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecentSearchContainer(
                      name: _getUserCubit .searchList[index],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
