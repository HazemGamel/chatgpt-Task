import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gpttask/shared/components/navigator.dart';

import '../../shared/components/my_divider.dart';
import '../../shared/style/images.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [

        ],
      ),
    );
  }
}
