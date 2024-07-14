import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';

class EditDescriptionWidget extends StatefulWidget {
  const EditDescriptionWidget({Key? key}) : super(key: key);

  @override
  State<EditDescriptionWidget> createState() => _EditDescriptionWidgetState();
}

class _EditDescriptionWidgetState extends State<EditDescriptionWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = _getUserDataCubit.groupData.description;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[800],
        ),
        child: _isEditing
            ? TextFormField(
                controller: _descriptionController,
                autofocus: true,
                onFieldSubmitted: (value) async {
                  setState(() {
                    _isEditing = false;
                    _getUserDataCubit.groupData = _getUserDataCubit.groupData
                        .copyWith(description: _descriptionController.text);
                  });
                  await AuthDataSource.editGroupDescription(
                      _getUserDataCubit.groupData.id, value);
                },
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        _getUserDataCubit.groupData.category == GroupCategory.room.name ? 'Chat Room Description' : "Group Description",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _descriptionController.text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 62,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
