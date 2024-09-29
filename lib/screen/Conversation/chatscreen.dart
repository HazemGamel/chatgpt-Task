import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../shared/components/chat_widget.dart';
import '../../shared/components/my_divider.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/providers/chatsprovider.dart';
import '../../shared/style/color.dart';
import '../../shared/style/enum/enum.dart';
import '../../shared/style/images.dart';

class ChatScreen extends StatelessWidget {

  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final chatsProvider = Provider.of<ChatsProvider>(context)..initState();
    return Scaffold(
      appBar:AppBar(
      elevation: 0,
      leadingWidth: double.infinity,
      automaticallyImplyLeading: false,
      leading: Container(
        width: 335,
        height: 64,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsetsDirectional.zero,
                  icon: const ImageIcon(AssetImage(Assets.imagesArrowBack)),
                  onPressed: () {
                    pop(context);
                  },
                ),
                Text(
                  'Back',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(Assets.imagesLogo),
                const SizedBox(width: 5),
              ],
            ),
            const MyDivider(),
          ],
        ),
      ),
    ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:chatsProvider.getmessages.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                chatsProvider.getmessages.isEmpty
                    ? const Spacer()
                    : const SizedBox(),
                chatsProvider.getmessages.isEmpty
                    ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ask anything, get your answer',
                    textAlign: TextAlign.center,
                    style:
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: chatsProvider.currentTheme==AppTheme.darkTheme?
                      AppMainColors.greyColor:AppMainColors.secondColor,
                    ),
                  ),
                )
                    : Flexible(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          controller:chatsProvider.listScrollController,
                          itemCount:chatsProvider.getmessages.length, //chatList.length,
                          itemBuilder: (context, index) {
                            return ChatWidget(
                              chatcolor: chatsProvider.currentTheme==AppTheme.darkTheme?
                              AppMainColors.greyColor:AppMainColors.greyColor ,
                              textcolor:chatsProvider.currentTheme==AppTheme.darkTheme?
                              AppMainColors.whiteColor:AppMainColors.whiteColor  ,
                              msg: chatsProvider.
                              getmessages[index].message,
                              chatIndex: chatsProvider.messages[index].isUser,
                              shouldAnimate:
                              chatsProvider.getmessages.length - 1 ==
                                  index,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                        ),
                      ),
                      if (!chatsProvider.isTyping)
                        Container(
                          width: 210.w,
                          height: 30,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 7),
                          decoration: ShapeDecoration(
                            color: AppMainColors.darkColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: AppMainColors.whiteColor
                                    .withOpacity(0.20000000298023224),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: const Stack(children: [
                                  ImageIcon(
                                    AssetImage(
                                      Assets.imagesRegenerate,
                                    ),
                                    color: AppMainColors.whiteColor,
                                  ),
                                ]),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Regenerate response',
                                style: TextStyle(
                                  color: chatsProvider.currentTheme==AppTheme.darkTheme?
                                  AppMainColors.whiteColor:AppMainColors.whiteColor ,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (chatsProvider.isTyping) ...[
                  Container(
                    width: 61,
                    height: 43,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: chatsProvider.currentTheme==AppTheme.darkTheme?
                      AppMainColors.whiteColor:AppMainColors.darkColor ,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    child:  SpinKitThreeBounce(
                      color: chatsProvider.currentTheme==AppTheme.darkTheme?
                      AppMainColors.darkColor:AppMainColors.whiteColor ,
                      size: 18,
                    ),
                  ),
                ],
                const SizedBox(
                  height: 15,
                ),
                chatsProvider.getmessages.isEmpty
                    ? const Spacer()
                    : const SizedBox(),
                DefaultTextFormField(
                  controller:chatsProvider.textEditingController,
                  keyboardType: TextInputType.multiline,
                  suffixPressed: () async {
                   await chatsProvider.sendMessage(context);
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Please type a message";
                    }
                    return null;
                  },
                  hint: '',
                  suffix: const AssetImage(Assets.imagesSend),
                  filecolor: chatsProvider.currentTheme==AppTheme.darkTheme?
                  AppMainColors.secondColor:AppMainColors.greyColor,
                ),
                const SizedBox(
                  height: 15,
                ),
              ]),
        ),
      ),
    );
  }
}
