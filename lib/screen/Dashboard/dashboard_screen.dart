import 'package:gpttask/screen/Conversation/chatscreen.dart';
import 'package:gpttask/shared/style/images.dart';
import 'package:gpttask/shared/components/chat_widget.dart';
import 'package:gpttask/shared/components/my_divider.dart';
import 'package:gpttask/shared/components/navigator.dart';
import 'package:gpttask/shared/style/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../shared/components/listofoptions.dart';
import '../../shared/providers/chatsprovider.dart';
import '../questions/questionsscreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatsProvider = Provider.of<ChatsProvider>(context)
      ..initState();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: AppMainColors.darkColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
          backgroundColor: AppMainColors.darkColor,
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                navigateTo(context, const ChatScreen());
              },
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                height: 52.h,
                width: 335.w,
                decoration: BoxDecoration(
                    color: AppMainColors.darkColor,
                    borderRadius: BorderRadius.circular(1)),
                child: Row(
                  children: [
                    const ImageIcon(
                      color: AppMainColors.whiteColor,
                      AssetImage(Assets.imagesMessage),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      'New Chat',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    const ImageIcon(
                      color: AppMainColors.whiteColor,
                      AssetImage(Assets.imagesArrowForward2),
                    ),
                  ],
                ),
              ),
            ),
            const MyDivider(horizontal: 20),
            if (chatsProvider.getmessages.isNotEmpty)
              GestureDetector(
                onTap: () {
                  navigateTo(context, const ChatScreen());
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  height: 52.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      color: AppMainColors.darkColor,
                      borderRadius: BorderRadius.circular(1)),
                  child: Row(
                    children: [
                      const ImageIcon(
                        color: AppMainColors.whiteColor,
                        AssetImage(Assets.imagesMessage),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: chatsProvider
                                .getmessages.length, //chatList.length,
                            itemBuilder: (context, index) {
                              if(chatsProvider.messages[index].isUser)
                               {
                                return DashboardChatList(
                                  msg: chatsProvider.getmessages[index]
                                      .message,
                                  shouldAnimate:
                                  chatsProvider.getmessages.length - 1 ==
                                          index,
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                      ),
                      const ImageIcon(
                        color: AppMainColors.whiteColor,
                        AssetImage(Assets.imagesArrowForward2),
                      ),
                    ],
                  ),
                ),
              ),
            const MyDivider(horizontal: 20),
            const Spacer(),
            const MyDivider(),
            Container(
              height: 316.h,
              width: 375.w,
              margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
              ),
              decoration: const BoxDecoration(
                color: AppMainColors.darkColor,
              ),
              child: Column(
                children: [
                  ListOfOptions(
                    imageIcon: Assets.imagesDelete,
                    text: 'Clear conversations',
                    function: () {
                      chatsProvider.clearMessages();
                    },
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: ListOfOptions(
                          function: () {
                          },
                          imageIcon: Assets.imagesUser,
                          text: 'Upgrade to Plus',
                        ),
                      ),
                      Container(
                        width: 50.w,
                        height: 20.h,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0.50),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFAF3AD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'NEW',
                              style: Theme.of(context).
                              textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                    },
                    imageIcon: Assets.imagesSun,
                    text: 'Light mode',
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                      navigateTo(context, QuestionsScreen());
                    },
                    imageIcon: Assets.imagesUpdates,
                    text: 'Updates & FAQ',
                  ),
                  SizedBox(height: 8.h),
                  ListOfOptions(
                    function: () {
                    },
                    imageIcon: Assets.imagesLogout,
                    text: 'Logout',
                    textColor: AppMainColors.redColor,
                    iconColor: AppMainColors.redColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

