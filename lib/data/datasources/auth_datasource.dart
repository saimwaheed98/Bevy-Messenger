import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/helper/conversation_id_getter.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/pages/subscription/data/model/subscription_model.dart';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../core/di/service_locator_imports.dart';

class AuthDataSource {
  // firebase auth instance
  static final FirebaseAuth auth = FirebaseAuth.instance;
  // firebase cloud firestore instance
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // firebase storage instance
  static final FirebaseStorage storage = FirebaseStorage.instance;
  // firebase messaging instance
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // for getting and updating the pushToken in firestore
  static Future<String> getFirebaseMessagingToken() async {
    String userPushToken = "";
    await messaging.requestPermission();
    await messaging.getToken(
    ).then((pushToken) {
      if (pushToken != null) {
        debugPrint('Push Token: $pushToken');
        userPushToken = pushToken;
      }
    });
    return userPushToken;
  }

  // sending the push notification
  static Future<void> sendPushNotification(String pushToken, String msg, String roomId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    try {
      final body = {
        "to": pushToken,
        "notification": {
          "title": authCubit.userData.name,
          "body": msg,
          "android_channel_id": "chats",
        },
        "data": {
          "screen": "chat",
          "room_id": roomId,
        },
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAADqgpULI:APA91bHSDchJrirsYTee7NGXX4gaJzsY8Vz77h3W9eAuXjUfFk_N-FNBxIuPhT7Hyh6h55u13fOSbpbN44DnBbmCIk-Slyl_5IydvxJeDtvf0Gh0od-HhUCLnoM65eOQfCvKObolhmHd'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  // get self info from firestore
  static Future<UserModel> getSelfInfo() async {
    try {
      final user = auth.currentUser;
      final doc = await firestore.collection('users').doc(user?.uid).get();
      return doc.data() != null
          ? UserModel.fromJson(doc.data() as Map<String, dynamic>)
          : const UserModel();
    } catch (e) {
      log('getSelfInfoE or user is not log in: $e');
      throw Exception('Error while getting self info');
    }
  }

  // add chat users to firestore
  static Future<void> addChatUsers(UserModel userData) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    try {
      await firestore
          .collection('users')
          .doc(authCubit.userData.id)
          .collection("chatUsers")
          .doc(userData.id)
          .set({});
    } catch (e) {
      log('addChatUsersE: $e');
      throw Exception('Error while adding chat users');
    }
  }

  // get chat users ids
  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatUsersIds() {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    return firestore
        .collection('users')
        .doc(authCubit.userData.id)
        .collection("chatUsers")
        .snapshots();
  }

  // get the list of subscriptions
  static Future<List<SubscriptionModel>> getSubscriptions() async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    var data = await firestore
        .collection('users')
        .doc(authCubit.userData.id)
        .collection("subscriptions")
        .get();
    List<SubscriptionModel> subscriptions =
        data.docs.map((e) => SubscriptionModel.fromJson(e.data())).toList();
    return subscriptions;
  }

  // uploade the image to firebase storage
  static Future<String> uploadProfileImage(File image) async {
    try {
      // get the name of the image file
      final fileName = image.path.split('/').last;
      // get the extension of the image file
      final ext = fileName.split('.').last;
      final user = auth.currentUser;
      final ref = storage.ref().child('profileImages/${user?.uid}/$fileName');
      await ref.putFile(image, SettableMetadata(contentType: 'image/$ext'));
      final url = await ref.getDownloadURL();
      await firestore
          .collection('users')
          .doc(user?.uid)
          .update({'imageUrl': url});
      return url;
    } catch (e) {
      log('uploadImageE: $e');
      throw Exception('Error while uploading image');
    }
  }

  // upload the image to firebase storage
  static Future<String> uploadGroupImage(File image) async {
    try {
      // get the name of the image file
      final fileName = image.path.split('/').last;
      // get the extension of the image file
      final ext = fileName.split('.').last;
      final user = auth.currentUser;
      final ref = storage.ref().child('groupImages/${user?.uid}/$fileName');
      await ref
          .putFile(image, SettableMetadata(contentType: 'image/$ext'))
          .then((p0) {
        log(p0.bytesTransferred.toString());
      });
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      log('uploadImageE: $e');
      throw Exception('Error while uploading image');
    }
  }

  // update the user info in firestore
  static Future<void> updateUserInfo(String name, String country, String city,
      String state, String phoneNumber) async {
    try {
      final user = auth.currentUser;
      await firestore.collection('users').doc(user?.uid).update({
        'name': name,
        'country': country,
        'city': city,
        "state": state,
        "phone": phoneNumber
      });
    } catch (e) {
      log('updateUserInfoE: $e');
      throw Exception('Error while updating user info');
    }
  }

  // update online status
  static Future<void> updateActiveStatus(bool isOnline,) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore.collection('users').doc(authCubit.userData.id).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  // update push token
  static Future<void> updatePushToken(String pushToken) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore.collection('users').doc(authCubit.userData.id).update({
      'pushToken': pushToken,
    });
  }

  // upload the image to firebase storage
  static Future<String> uploadFile(
      File image, String storePath, String type) async {
    try {
      // get the name of the image file
      final fileName = image.path.split('/').last;
      // get the extension of the image file
      final ext = fileName.split('.').last;
      final user = auth.currentUser;
      final ref = storage.ref().child('$storePath/${user?.uid}/$fileName');
      await ref
          .putFile(image, SettableMetadata(contentType: '$type/$ext'))
          .then((p0) {
        log(p0.bytesTransferred.toString());
      });
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      log('uploadImageE: $e');
      throw Exception('Error while uploading image');
    }
  }

  // delete the group
  static Future<void> deleteGroup(String groupId) async {
    await firestore.collection('groups').doc(groupId).delete();
  }

  // edit the group description
  static Future<void> editGroupDescription(
      String groupId, String description) async {
    await firestore.collection('groups').doc(groupId).update({
      'description': description,
    });
  }

  // add the participants to the group
  static Future<void> addParticipantsToGroup(
      String groupId, List<String> participants) async {
    await firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayUnion(participants),
      "updatedAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "updatedBy": auth.currentUser?.uid
    });
  }

  // remove the participants from the group
  static Future<void> removeParticipiants(
      String groupId, List<String> participants) async {
    await firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayRemove(participants),
      "updatedAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "updatedBy": auth.currentUser?.uid
    });
  }

  // update the group is premium or not
  static Future<void> updateGroupIsPremium(
      String groupId, bool isPremium) async {
    await firestore.collection('groups').doc(groupId).update({
      'premium': isPremium,
      "updatedAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "updatedBy": auth.currentUser?.uid
    });
  }

  // update the subscription status of the group
  static Future<void> updateUserSubscription(
      bool isSubscribed, String byedGroupId, String buyedGroupName) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    var uuid = const Uuid().v4();
    var data = SubscriptionModel(
      subscribedGroupId: byedGroupId,
      subscribedGroupName: buyedGroupName,
      endingData: DateTime.now().add(const Duration(days: 31)).toString(),
      subscribedData: DateTime.now().toString(),
      subscriptionId: uuid,
      subscriptionStatus: isSubscribed,
      userId: authCubit.userData.id,
    );
    await firestore
        .collection("users")
        .doc(authCubit.userData.id)
        .collection("subscriptions")
        .doc(uuid)
        .set(data.toJson());
    authCubit.updateSubscriptionList(data);
  }

  // update the value of the subscription status for a group
  static Future<void> addTheGroupToUserSubscription(
      String groupId, String groupName, String id) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore
        .collection("users")
        .doc(authCubit.userData.id)
        .collection("subscriptions")
        .doc(id)
        .update({
      "subscribedGroupId": groupId,
      "subscriptionStatus": false,
      "subscribedGroupName": groupName
    });
    await firestore.collection("groups").doc(groupId).update({
      "members": FieldValue.arrayUnion([authCubit.userData.id]),
    });
  }

  // update the subscription or the room
  static Future<void> updateTheSubscription(String subscriptionId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore
        .collection("users")
        .doc(authCubit.userData.id)
        .collection("subscriptions")
        .doc(subscriptionId)
        .update({
      "endingData": DateTime.now().add(const Duration(days: 30)).toString(),
    });
    authCubit.updateTheSubscriptionForMonth(subscriptionId);
  }

  // add the user in the blocklist
  static Future<void> addBlockedUser(String userId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore.collection('users').doc(authCubit.userData.id).update({
      'blockedUsers': FieldValue.arrayUnion([userId]),
    });
    await firestore.collection('users').doc(userId).update({
      'blockedBy': FieldValue.arrayUnion([authCubit.userData.id]),
    });
  }

  // unblock the user from the blocklist
  static Future<void> unBlockUser(String userId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore.collection('users').doc(authCubit.userData.id).update({
      'blockedUsers': FieldValue.arrayRemove([userId]),
    });
    await firestore.collection('users').doc(userId).update({
      'blockedBy': FieldValue.arrayRemove([authCubit.userData.id]),
    });
  }

  // delete the conversation in firestore
  static Future<void> deleteConversation(String userId) async {
    String chatId = conversationId(userId);
    // First, get all messages within the conversation
    QuerySnapshot messagesSnapshot = await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .get();
    // Delete each message
    for (DocumentSnapshot messageDoc in messagesSnapshot.docs) {
      await messageDoc.reference.delete();
    }
    // Now delete the conversation document itself
    await firestore
        .collection('chats')
        .doc(chatId)
        .delete()
        .then((value) async {
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('chatUsers')
          .doc(userId)
          .delete();
      log("Conversation Deleted");
    });
  }

// remove the user from group unread message
  static Future<void> removeUserFromGroupUnreadMessage(String groupId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore.collection('groups').doc(groupId).update({
      'unreadMessageUsers': FieldValue.arrayRemove([authCubit.userData.id]),
    });
    log("user removed");
  }

  // send multiple notifications
  static Future<void> sendGroupNotification(
      List<String> members, String msg, String roomId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await firestore
        .collection("users")
        .where("id", whereIn: members)
        .get()
        .then((value) {
      var data = value.docs;
      List<UserModel> users =
          data.map((e) => UserModel.fromJson(e.data())).toList();
      users.removeWhere((element) => element.id == authCubit.userData.id);
      for (var i in users) {
        sendPushNotification(i.pushToken, msg, roomId);
      }
    });
  }


  // get the other user name from database
  static Future<List<String>> getOtherUsernames()async{
    List<String> otherUsernames = [];
    await firestore.collection('users').get().then((value) {
      for (var element in value.docs) {
        String username = element.data()['name'];
        otherUsernames.add(username.toLowerCase());
      }
    });
    return otherUsernames;
  }
  static Future<List<String>> getOtherEmails()async{
    List<String> otherUsernames = [];
    await firestore.collection('users').get().then((value) {
      for (var element in value.docs) {
        String username = element.data()['email'];
        otherUsernames.add(username.toLowerCase());
      }
    });
    return otherUsernames;
  }
}
