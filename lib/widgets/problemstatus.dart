import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemStatus extends StatefulWidget {
  final Function onChanged;
  int selected = 0;
  ProblemStatus({this.selected, this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return _ProblemStatus();    
  }
}

class _ProblemStatus extends State<ProblemStatus> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => widget.selected = 0);
              widget.onChanged(0);
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.selected == 0 ? Colors.grey : Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.selected == 0 ? 'Not Solved' : 'NS',
                  style: GoogleFonts.nunito(color: widget.selected == 0 ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() => widget.selected = 1);
              widget.onChanged(1);
            },
            child: Container(
              color: widget.selected == 1 ? Colors.green : Colors.grey.withAlpha(30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.selected == 1 ? 'Solved' : 'AC',
                  style: GoogleFonts.nunito(color: widget.selected == 1 ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() => widget.selected = 2);
              widget.onChanged(2);
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.selected == 2 ? Colors.red : Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.selected == 2 ? 'Can\'t Solve' : 'CS',
                  style: GoogleFonts.nunito(color: widget.selected == 2 ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );   
  }
}