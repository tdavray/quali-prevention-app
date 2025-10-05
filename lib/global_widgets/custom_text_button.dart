import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/style.dart';

class CustomTextButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color disabledColor;
  final Color textColor;
  final Color disabledTextColor;
  final BorderSide enabledBorder;
  final BorderSide disabledBorder;
  final bool isLoading;

  const CustomTextButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.disabledColor,
    required this.textColor,
    required this.disabledTextColor,
    required this.enabledBorder,
    required this.disabledBorder,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledColor;
            }
            return backgroundColor;
          },
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 15),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: isEnabled ? enabledBorder : disabledBorder,
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 26,
              width: 26,
              child: CircularProgressIndicator(color: white),
            )
          : Text(
              text,
              style: GoogleFonts.poppins(
                color: isEnabled ? textColor : disabledTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
