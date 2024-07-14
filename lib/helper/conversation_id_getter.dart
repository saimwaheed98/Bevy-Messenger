import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';

String conversationId(String id) {
  final AuthCubit authCubit = Di().sl<AuthCubit>();
  return authCubit.userData.id.hashCode >= id.hashCode
      ? '${authCubit.userData.id}-$id'
      : '$id-${authCubit.userData.id}';
}
