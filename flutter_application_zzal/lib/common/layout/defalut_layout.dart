import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavagationBar;

  const DefaultLayout(
      {this.bottomNavagationBar,
      this.title,
      this.backgroundColor,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavagationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        foregroundColor: Colors.black,
        actions: const [],
      );
    }
  }
}
