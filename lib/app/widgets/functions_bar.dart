import 'package:flutter/material.dart';

class FuctionsBar extends StatelessWidget implements PreferredSizeWidget {
  const FuctionsBar({
    required this.child,
    super.key,
  });

  final double height = 56;
  final Widget child;

  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: child,
    );
  }
}
