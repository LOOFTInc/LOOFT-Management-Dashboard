import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/pages/authentication/login/widgets/login_card.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/copyright.dart';
import 'package:management_dashboard/presentation/widgets/scrollable_widget.dart';

import '../../../widgets/gaps_and_paddings/horizontal_padding.dart';

class LoginPage extends StatelessWidget {
  /// The login page for the app
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ScrollableWidget(
          scrollDirection: Axis.vertical,
          minSize: 670,
          widgetSize: 670,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: HorizontalPadding(
              padding: 48,
              mobilePadding: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: K.maxScreenWidth,
                    ),
                    child: MediaQuery.of(context).size.width < K.mobileSize
                        ? const LoginCard()
                        : Row(
                            children: [
                              Expanded(
                                child:
                                    SvgPicture.asset('assets/images/logo.svg'),
                              ),
                              const LoginCard(),
                            ],
                          ),
                  ),
                  const Spacer(),
                  const Copyright(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
