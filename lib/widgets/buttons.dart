import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    this.buttonTitle,
    required this.onPressed,
    this.imageLeft,
    this.iconLeft,
    this.iconRight,
    this.bgColor = const Color(0xffff6900),
    this.textColor = const Color(0xffffffff),
    this.iconBgColor = Colors.transparent,
    this.border = BorderSide.none,
    this.horzPad = 8,
    this.vertPad = 14,
  });
  final String? buttonTitle;
  final void Function()? onPressed;
  final Image? imageLeft;
  final Icon? iconLeft;
  final Icon? iconRight;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconBgColor;
  final BorderSide border;
  final double vertPad;
  final double horzPad;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color?>(widget.textColor),
        backgroundColor: WidgetStateProperty.all<Color?>(widget.bgColor),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
            EdgeInsets.symmetric(
                vertical: widget.vertPad, horizontal: widget.horzPad)),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
              side: widget.border, borderRadius: BorderRadius.circular(8));
        }),
        elevation: WidgetStateProperty.all<double>(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: widget.imageLeft == null
                ? null
                : const EdgeInsets.only(right: 12),
            child: widget.imageLeft,
          ),
          Container(
            padding: widget.iconLeft == null ? null : const EdgeInsets.all(8),
            margin: widget.iconLeft == null
                ? null
                : widget.buttonTitle != null
                    ? const EdgeInsets.only(right: 12)
                    : null,
            decoration: BoxDecoration(
                color: widget.iconBgColor,
                borderRadius: BorderRadius.circular(8)),
            child: widget.iconLeft,
          ),
          if (widget.buttonTitle != null)
            Text(
              widget.buttonTitle!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          Container(
            padding: widget.iconRight == null
                ? null
                : const EdgeInsets.only(right: 12),
            child: widget.iconRight,
          ),
        ],
      ),
    );
  }
}
