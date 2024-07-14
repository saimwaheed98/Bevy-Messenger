import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/conversation_id_getter.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetMessagesDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId);
}

class GetMessagesDataSourceImpl extends GetMessagesDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId) {
    final GetUserDataCubit getUserData = Di().sl<GetUserDataCubit>();
    return AuthDataSource.firestore
        .collection("chats")
        .doc(getUserData.chatStatus == ChatStatus.user
            ? conversationId(userId)
            : getUserData.groupData.id)
        .collection("messages")
        .orderBy("sent", descending: true)
        .snapshots();
  }
}
