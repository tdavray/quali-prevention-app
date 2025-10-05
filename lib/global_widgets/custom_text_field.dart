import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_academy_app/common/style.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isObscure;
  final ValueChanged<String> onChanged;
  final VoidCallback onUnfocus;
  final bool isEmpty;
  final int maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isObscure = false,
    required this.onChanged,
    required this.onUnfocus,
    this.isEmpty = true,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    // Listen to the focus changes
    widget.focusNode.addListener(() {
      setState(() {
        isFocused = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.focusNode.requestFocus(),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: TextFormField(
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          minLines: 1,
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.isObscure,
          cursorHeight: 20,
          cursorColor: textPrimary,
          style: GoogleFonts.poppins(
            color: textBlack,
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
            icon: Icon(widget.icon, color: textPrimary, size: 20),
            labelText: widget.labelText,
            labelStyle: GoogleFonts.poppins(
              color: textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: !widget.isEmpty && isFocused
                ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        widget.controller.clear();
                        widget.onChanged('');
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  )
                : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: textPrimary),
            ),
            enabledBorder: InputBorder.none,
            border: null,
          ),
          onChanged: widget.onChanged,
          onTapOutside: (event) {
            if (widget.focusNode.hasFocus) {
              widget.onUnfocus();
            }
          },
        ),
      ),
    );
  }
}
