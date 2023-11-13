import 'package:flutter/material.dart';

class ConfirmationButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final Function()? onPress;

  const ConfirmationButton({
    super.key,
    required this.label,
    this.width,
    this.height,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
        onPressed: onPress,
        child: Text(
          label,
        ),
      ),
    );
  }
}
