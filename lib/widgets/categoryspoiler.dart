import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySpoiler extends StatefulWidget {
  final String spoilerText;
  bool isHidden;
  CategorySpoiler(this.spoilerText, this.isHidden);

  @override
  State<StatefulWidget> createState() {
    return _CategorySpoiler();    
  }
}

class _CategorySpoiler extends State<CategorySpoiler> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 30,

      decoration: BoxDecoration(
        color: widget.isHidden ? Colors.grey.withAlpha(60) : Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(6)
      ),

      child: Material(
        borderRadius: BorderRadius.circular(6),
        color: widget.isHidden ? Colors.grey.withAlpha(60) : Colors.grey.withAlpha(30),
        child: InkWell(
        borderRadius: BorderRadius.circular(6),

          onTap: () { setState(() {
            widget.isHidden = !widget.isHidden;
          });} ,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Text(
              widget.isHidden ? "Show Spoiler" : widget.spoilerText,
              style: GoogleFonts.nunito(
                fontWeight: widget.isHidden ? FontWeight.w600 : FontWeight.w500
              ),
            ),
          ),
        ),
      ),
    );   
  }
}