import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/widgets/participiant_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../utils/colors.dart';

class ParticipiantList extends StatelessWidget {
  const ParticipiantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateGroupCubit createGroupCubit = Di().sl<CreateGroupCubit>();
    return BlocBuilder(
      bloc: createGroupCubit,
      builder: (context, state) {
        return ListView.builder(
          itemCount: createGroupCubit.participants.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var list = createGroupCubit.participants[index];
            return Slidable(
              direction: Axis.horizontal,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                    _createGroupCubit.removeParticipiant(list);
                    },
                    backgroundColor: AppColors.secRedColor,
                    foregroundColor: Colors.white,
                    flex: 4,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    autoClose: true,
                    icon: Icons.delete,
                    label: "Remove"
                  ),
                ],
              ),
              child: ParticipiantContainer(
                user: list,
              ),
            );
          },
        );
      },
    );
  }
}


final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();