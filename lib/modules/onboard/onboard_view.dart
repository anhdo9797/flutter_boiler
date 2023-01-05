import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';
import 'package:flutter_boiler/share/constants/assets.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final controller = PageController();

  bool isEndPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildPage(
          color: Colors.brown[800],
          asset: Assets.onboard1,
          title: "Title onboard page 1"),
      _buildPage(
          color: const Color(0xff90143F),
          asset: Assets.onboard2,
          title: "Title onboard page 2"),
      _buildPage(
          color: Colors.purple[800],
          asset: Assets.onboard3,
          title: "Title onboard page 3"),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: ((value) =>
                setState(() => isEndPage = value == (pages.length - 1))),
            children: pages,
          ),
          Positioned(
            bottom: 12,
            right: 16,
            left: 16,
            child: SafeArea(
              child: isEndPage
                  ? ButtonWidget(onPressed: _onGetStated, label: "Get started")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          onPressed: () => controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn),
                          label: "Prev",
                          type: ButtonType.ghost,
                        ),
                        SmoothPageIndicator(
                          count: pages.length,
                          controller: controller,
                          onDotClicked: (index) => controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                          effect: WormEffect(
                              spacing: 16,
                              dotColor: Colors.black26,
                              activeDotColor:
                                  Theme.of(context).colorScheme.primary),
                        ),
                        ButtonWidget(
                          onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn),
                          label: "Next",
                          type: ButtonType.ghost,
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  _buildPage(
      {required Color? color, required String title, required String asset}) {
    final s = SizeConfig();
    return Container(
      decoration: BoxDecoration(color: color),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
          image: AssetImage(asset),
          width: s.screenWidth * 0.8,
        ),
        const Space(height: 20),
        Text(title)
      ]),
    );
  }

  _onGetStated() {
    AppPref.firstInstall = false;
    AppRouter.routes.goNamed(APP_PAGE.auth.toName);
  }
}
