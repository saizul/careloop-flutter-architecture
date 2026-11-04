import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= Breakpoints.tablet) {
      return desktop ?? tablet ?? mobile;
    }

    if (width >= Breakpoints.mobile) {
      return tablet ?? mobile;
    }

    return mobile;
  }
}
