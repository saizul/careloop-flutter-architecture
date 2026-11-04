import 'package:flutter/material.dart';

class AdaptivePageScaffold extends StatelessWidget {
  const AdaptivePageScaffold({
    required this.body,
    this.title,
    this.actions,
    super.key,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!),
              actions: actions,
            ),
      body: SafeArea(child: body),
    );
  }
}
