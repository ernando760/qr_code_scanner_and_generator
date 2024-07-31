import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/home/controllers/bottom_navigation_bar_controller.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  const CustomBottomNavigationBarWidget(
      {super.key, required this.controller, required this.items, this.onTap});
  final BottomNavigationController controller;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return BottomNavigationBar(
          currentIndex: controller.indexCurrent,
          items: items,
          onTap: onTap,
        );
      },
    );
  }
}
