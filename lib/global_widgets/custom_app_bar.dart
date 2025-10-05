import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_academy_app/common/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? showBackButton; // Nullable, let the widget decide when null
  final VoidCallback? onBackButtonPressed;
  final double toolbarHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton, // Leave it null to decide based on navigation stack
    this.onBackButtonPressed,
    this.toolbarHeight = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the page can pop (i.e., if there are previous pages in the stack)
    bool canPop = Navigator.of(context).canPop();
    bool shouldShowBackButton = showBackButton ?? canPop;

    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: white,
      toolbarHeight: toolbarHeight,
      elevation: 0,
      leading: shouldShowBackButton
          ? IconButton(
              onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
              icon: Transform.translate(
                offset: const Offset(5, 0),
                child: const Icon(Icons.arrow_back_ios),
              ),
              color: textPrimary,
            )
          : null, // No leading widget if back button is not needed
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
