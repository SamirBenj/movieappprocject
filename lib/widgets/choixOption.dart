import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
