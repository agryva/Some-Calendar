import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum SnackBarMode { error, success, black }

class SnackBarModeColor {
  SnackBarModeColor({required this.background,required  this.color});

  final Color background;
  final Color color;
}

class Helpers {
  static void showSnackBar(
      BuildContext context, {
        required SnackBarMode snackBarMode,
        required String content,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        style: GoogleFonts.inter(
          color: snackbarColor(snackBarMode).color,
        ),
      ),
      backgroundColor: snackbarColor(snackBarMode).background,
      behavior: SnackBarBehavior.floating,
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
    ),);
  }

  static SnackBarModeColor snackbarColor(SnackBarMode snackbar) {
    if (snackbar == SnackBarMode.success) {
      return SnackBarModeColor(
        background: const Color(0xffAAEEC9),
        color: const Color(0xff22AA5F),
      );
    } else if (snackbar == SnackBarMode.error) {
      return SnackBarModeColor(
        background: const Color(0xffFFB7B7),
        color: const Color(0xffB61616),
      );
    } else {
      return SnackBarModeColor(
        background: const Color(0xff2F3B43),
        color: Colors.white,
      );
    }
  }
}