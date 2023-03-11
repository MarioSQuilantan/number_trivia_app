import 'package:flutter/widgets.dart';

import '../../core/layout/screen.layout.dart';
import 'layouts/desktop/desktop.layout.dart';
import 'layouts/phone/phone.layout.dart';
import 'layouts/tablet/tablet.layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ScreenLayout(
        mobileLayout: PhoneLayout(),
        tabletLayout: TabletLayout(),
        desktopLayout: DesktopLayout(),
      ),
    );
  }
}
