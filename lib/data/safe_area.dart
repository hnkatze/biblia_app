import 'package:flutter/material.dart';

class SafeAreaCustom extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final bool? left;
  final bool? top;
  final bool? right;
  final bool? bottom;
  const SafeAreaCustom({
    super.key,
    required this.child,
    this.statusBarColor = const Color(0x00FFFFFF),
    this.left = false,
    this.top = true,
    this.right = false,
    this.bottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: statusBarColor,
      child: SafeArea(
        top: top!,
        left: left!,
        right: right!,
        bottom: bottom!,
        child: child,
      ),
    );
  }
}
