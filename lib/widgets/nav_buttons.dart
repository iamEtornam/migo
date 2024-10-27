import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tooltipMessage,
    this.isActive = false,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final bool isActive;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        hoverColor: Colors.black,
        tooltip: tooltipMessage,
        icon: Icon(
          icon,
          size: 24,
          color: isActive ? Colors.white : const Color(0xff6C6BA9),
        ),
      ),
    );
  }
}
