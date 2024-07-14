import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/payment_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/subscription/data/model/subscription_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/widgets/gesture_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SubscriptionPage extends StatefulWidget {
  final bool isSubscribing;
  const SubscriptionPage({super.key, required this.isSubscribing});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool isSubscribed = false;
  String privacyUrl =
      "https://firebasestorage.googleapis.com/v0/b/bevy-messenger.appspot.com/o/Privacy%20Policy.txt?alt=media&token=3c0015e0-829b-496d-9a2c-755d78eebd6a";
  String termsUrl =
      "https://firebasestorage.googleapis.com/v0/b/bevy-messenger.appspot.com/o/Terms%20Of%20Service.txt?alt=media&token=6b831d21-a6a8-47d5-88b1-0066772af068";
  @override
  initState() {
    super.initState();
    for (var element in _authCubit.userSubscriptions) {
      log("the subscription is pending ${element.subscriptionStatus}");
      if (element.subscriptionStatus == true) {
        setState(() {
          isSubscribed = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.5),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const AppTextStyle(
                  text: 'Get Access to Our Premium Chat Rooms',
                  fontSize: 32,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 16,
              ),
              const AppTextStyle(
                  text:
                      'Subscribe for access to Chat Rooms, pick and choose which Room you want to subscribe to. Join millions of other members who want to converse.',
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400),
              const SizedBox(
                height: 48,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: AppColors.fieldsColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextStyle(
                            text: 'Premium Chat Rooms',
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        // Container(
                        //   height: 22,
                        //   width: 75,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: AppColors.redColor,
                        //   ),
                        //   child: const Center(
                        //     child: AppTextStyle(
                        //       text: 'Best Value',
                        //       fontSize: 10,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextStyle(
                        text: _authCubit.userData.email == "admin@ourbevy.com" ? "Checkout" : isSubscribed
                            ? "You have purchased our one chat room package now you can get one chat room"
                            : 'Premium Chat Room Price Per Chat Room is \$9.99 per month, via Subscription. You can unsubscribe at any time.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              BlocBuilder(
                bloc: _paymentCubit,
                builder: (context, state) {
                  return GestureContainer(
                      isLoading: _paymentCubit.isPaying,
                      onPressed: () async {
                        if (isSubscribed) {
                          _bottomBarCubit.changeIndex(2);
                          AutoRouter.of(context).pop();
                          // AutoRouter.of(context).push(GroupListRoute(
                          //   category: GroupCategory.room,
                          //     title: "Premium Rooms", premium: true));
                        } else {
                          await _paymentCubit.pay(context).then((value) async {
                            if (value == "success") {
                              if(widget.isSubscribing == true){
                                final checkSubscriptionId = _authCubit.userSubscriptions.where((element) => element.subscribedGroupId == _getUserDataCubit.groupData.id).toList();
                                SubscriptionModel data = checkSubscriptionId.first;
                                await AuthDataSource.updateTheSubscription(data.subscriptionId).then((value) {
                                  AutoRouter.of(context).pop();
                                });
                              }else{
                                await AuthDataSource.updateUserSubscription(true, "", "");
                                setState(() {
                                  isSubscribed = true;
                                });
                              }
                            }
                          });
                        }
                      },
                      buttonText:
                          isSubscribed ? "Access Chat Room" : 'Subscribe To Chat Room',
                      heroTag: '');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'dmSans',
                ),
                TextSpan(
                  text: 'By placing this order, you agree to the',
                  children: [
                    TextSpan(
                      text: ' Terms of Service',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.redColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'dmSans',
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL(termsUrl);
                        },
                    ),
                    const TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.redColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'dmSans',
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL(privacyUrl);
                        },
                    ),
                    const TextSpan(
                      text:
                          'Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    Uri _url = Uri.parse(url);
    if (await launchUrl(_url)) {
      log("url launched");
    } else {
      throw 'Could not launch $url';
    }
  }
}


final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final BottomBarCubit _bottomBarCubit = Di().sl<BottomBarCubit>();
final PaymentCubit _paymentCubit = Di().sl<PaymentCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
