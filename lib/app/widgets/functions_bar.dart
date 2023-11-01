import 'package:flutter/material.dart';

class FuctionsBar extends StatelessWidget implements PreferredSizeWidget {
  const FuctionsBar({
    required this.child,
    super.key,
  });

  final double height = 80;
  final Widget child;

  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: child,
    );
  }
}
