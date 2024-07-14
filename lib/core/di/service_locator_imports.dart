import 'package:bevy_messenger/bloc/cubits/check_app_update_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/get_notification_click_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/payment_cubit.dart';
import 'package:bevy_messenger/data/datasources/payment_datasource.dart';
import 'package:bevy_messenger/helper/image_picker.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:bevy_messenger/pages/bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/data/datasources/get_messages_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/datasources/send_file_message_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/datasources/send_group_file_message_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/datasources/send_message_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/datasources/send_message_group_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/repositories/send_file_message_repository_impl.dart';
import 'package:bevy_messenger/pages/chatpage/data/repositories/send_group_file_message_repository_impl.dart';
import 'package:bevy_messenger/pages/chatpage/data/repositories/send_group_message_repository_impl.dart';
import 'package:bevy_messenger/pages/chatpage/data/repositories/send_message_repository_impl.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/get_messages_repository.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_file_message_repository.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_group_file_message_repository.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_group_message_repository.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_message_repository.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/get_messages_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_file_message_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_group_message_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_message_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_group_file_message_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_group_message_cubit.dart';
import 'package:bevy_messenger/pages/chatroom/data/datasources/get_groups_datasource.dart';
import 'package:bevy_messenger/pages/chatroom/data/datasources/update_group_user_online_datasource.dart';
import 'package:bevy_messenger/pages/chatroom/data/repositories/get_groups_repository_impl.dart';
import 'package:bevy_messenger/pages/chatroom/data/repositories/update_group_user_online_repository_impl.dart';
import 'package:bevy_messenger/pages/chatroom/domain/repositories/get_groups_repository.dart';
import 'package:bevy_messenger/pages/chatroom/domain/repositories/update_group_user_online_repository.dart';
import 'package:bevy_messenger/pages/chatroom/domain/usecases/get_groups_usecase.dart';
import 'package:bevy_messenger/pages/chatroom/domain/usecases/update_group_user_online_usecase.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/bloc/cubit/update_user_group_online_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/data/datasources/create_group_datasource.dart';
import 'package:bevy_messenger/pages/creategroup/data/repositories/create_group_repository_impl.dart';
import 'package:bevy_messenger/pages/creategroup/domain/repositories/create_group_repository.dart';
import 'package:bevy_messenger/pages/creategroup/domain/usecases/create_group_usecase.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/gallery/presentation/bloc/cubit/gallery_cubit.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/bloc/cubit/remove_user_group_cubit.dart';
import 'package:bevy_messenger/pages/login/data/datasources/login_datasource.dart';
import 'package:bevy_messenger/pages/login/presentation/bloc/cubit/login_cubit.dart';
import 'package:bevy_messenger/pages/otp/data/repositories/resend_otp_repository_impl.dart';
import 'package:bevy_messenger/pages/otp/domain/repositories/resend_otp_repository.dart';
import 'package:bevy_messenger/pages/otp/domain/usecases/resend_otp_usecase.dart';
import 'package:bevy_messenger/pages/otp/presentation/bloc/cubit/resend_otp_cubit.dart';
import 'package:bevy_messenger/pages/otp/presentation/bloc/cubit/verify_otp_create_profile_cubit.dart';
import 'package:bevy_messenger/pages/privatechats/presentation/bloc/cubit/add_chat_users_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/datasources/create_profile_datasource.dart';
import 'package:bevy_messenger/pages/signup/data/repositories/create_profile_repositorie_impl.dart';
import 'package:bevy_messenger/pages/signup/domain/usecases/create_profile_usecase.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/cubits/auth_cubit.dart';
import '../../bloc/cubits/internet_con_cubit.dart';
import '../../data/datasources/check_notification_click_datasource.dart';
import '../../data/datasources/check_update_datasource.dart';
import '../../data/datasources/internet_connection_datasource.dart';
import '../../pages/chatpage/data/repositories/get_messages_repository_impl.dart';
import '../../pages/chatpage/domain/usecases/send_group_file_message_usecase.dart';
import '../../pages/chatpage/presentation/bloc/cubit/send_message_cubit.dart';
import '../../pages/login/data/repositories/login_repository_impl.dart';
import '../../pages/login/domain/repositories/login_repository.dart';
import '../../pages/login/domain/usecases/login_usecase.dart';
import '../../pages/login/presentation/bloc/cubit/validate_text_fields_cubit.dart';
import '../../pages/otp/data/datasources/resend_otp_datasource.dart';
import '../../pages/otp/data/datasources/verify_otp_datasource.dart';
import '../../pages/otp/data/repositories/verify_otp_repositorie_impl.dart';
import '../../pages/otp/domain/repositories/verify_otp_repositorie.dart';
import '../../pages/otp/domain/usecases/verify_otp_usercase.dart';
import '../../pages/privatechats/data/datasources/get_private_chat_datasource.dart';
import '../../pages/privatechats/data/repositories/get_private_chat_repository_impl.dart';
import '../../pages/privatechats/domain/repositories/get_private_chat_repository.dart';
import '../../pages/privatechats/domain/usercases/get_private_chat_usecase.dart';
import '../../pages/privatechats/presentation/bloc/cubit/get_private_chat_cubit.dart';
import '../../pages/signup/domain/repositories/create_profile_repositorie.dart';

part 'service_locator.dart';