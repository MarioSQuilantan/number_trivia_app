import 'package:flutter/widgets.dart';

import '../../core/layout/screen.layout.dart';
import 'layouts/desktop/home_desktop.layout.dart';
import 'layouts/phone/home_phone.layout.dart';
import 'layouts/tablet/home_tablet.layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ScreenLayout(
        mobileLayout: HomePhoneLayout(),
        tabletLayout: HomeTabletLayout(),
        desktopLayout: HomeDesktopLayout(),
      ),
    );
  }
}
