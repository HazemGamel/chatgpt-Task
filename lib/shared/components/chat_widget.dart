import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gpttask/shared/style/images.dart';
import 'package:gpttask/shared/components/text_widget.dart';
import 'package:gpttask/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardChatList extends StatelessWidget {
  const DashboardChatList({
    super.key,
    required this.msg,
    this.shouldAnimate = false, this.textColor,
  });
  final String msg;
  final Color? textColor;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextWidget(
        maxLine: 1,
        label: msg,
        textColor: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false, this.chatcolor, this.textcolor,
  });

  final String msg;
  final bool chatIndex;
  final bool shouldAnimate;
  final Color? chatcolor;
  final Color? textcolor;
  @override
  Widget build(BuildContext context) {
    if (chatIndex) {
      // For User
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(left: 40),
            decoration: ShapeDecoration(
              color: AppMainColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ).r,
              ),
            ),
            child: TextWidget(
              label: msg,
              textColor: AppMainColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      // For Bot
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 40),
            decoration: ShapeDecoration(
              color: chatcolor,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ).r,
              ),
            ),
            child: shouldAnimate
                ? DefaultTextStyle(
                    style: GoogleFonts.raleway(
                      color: textcolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        repeatForever: false,
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            msg,
                          ),
                        ]),
                  )
                : TextWidget(
                    label: msg,
                    textColor: textcolor,
                    fontWeight: FontWeight.w600,
                  ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const ImageIcon(
                AssetImage(Assets.imagesLike),
                color: AppMainColors.greyColor,
              ),
              const SizedBox(
                width: 16,
              ),
              const ImageIcon(
                AssetImage(Assets.imagesDisLike),
                color: AppMainColors.greyColor,
              ),
              const SizedBox(
                width: 41,
              ),
              const ImageIcon(
                AssetImage(Assets.imagesCopy),
                color: AppMainColors.greyColor,
              ),
              Text(
                'Copy',
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ],
      );
    }
  }
}
