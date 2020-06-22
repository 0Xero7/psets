import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/models/problemmodel.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/utilities/problemutils.dart';
import 'package:psettracker/widgets/categoryspoiler.dart';
import 'package:psettracker/widgets/customback.dart';
import 'package:psettracker/widgets/pagewrapper.dart';
import 'package:psettracker/widgets/problemstatus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DayProblems extends StatefulWidget {

  final int day;
  DayProblems({this.day = 1});

  bool status = false;
  Set<String> solved = new Set<String>();
  Set<String> cantSolve = new Set<String>();

  bool _dataFetched = false;

  @override
  State<StatefulWidget> createState() {
    return _Day1();    
  }
}

class _Day1 extends State<DayProblems> {
  List<ProblemModel> _problems;
  bool _updating = false;

  Future _loadProblems() async {
    if (widget._dataFetched) return;
    var docs = await Firestore.instance.document('problemset/day${widget.day}/').get();
    var problemIDs = docs.data['problems'];

    _problems = List<ProblemModel>();
    for (var id in problemIDs) {
      try {
        var problem = await Firestore.instance.document('problems/${id.toString().trim()}').get();
        _problems.add(ProblemModel.fromMap(id, problem.data));

        if (UserModel.solved_problems.contains(id.toString().trim())) widget.solved.add(id.toString().trim());
        if (UserModel.cant_solve_problems.contains(id.toString().trim())) widget.cantSolve.add(id.toString().trim());
      } catch (e) {
        print(e.toString());
        break;
      }
    }
    setState(() => widget._dataFetched = true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: PageWrapper(
        child: SizedBox.expand( // fill horizontal space

          child: Stack(
            children: [

              Positioned(
                top: 25,
                left: 10,

                child: CustomBack()
              ),
              
              Positioned(
                top : 17,
                left: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day ${widget.day}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      ' Easy',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              
              Positioned(
                top: 150,
                right: 20,
                left: 20,

                child: Center(
                  child: Text(
                    widget._dataFetched ? "Solved: ${widget.solved.length}/${_problems.length}" : "",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ),


              Positioned(
                top: 185,
                left: 0,
                right: 0,

                child: Container(
                  height: 15,
                  color: Colors.grey.withAlpha(65),
                ),
              ),
              Positioned(
                top: 185,
                left: 0,

                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,

                      height: 15,
                      width: widget._dataFetched ? MediaQuery.of(context).size.width * (widget.solved.length / _problems.length) : 0,
                      color: Colors.green.shade600.withAlpha(165),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,

                      height: 15,
                      width: widget._dataFetched ? MediaQuery.of(context).size.width * (widget.cantSolve.length / _problems.length) : 0,
                      color: Colors.red.shade600.withAlpha(165),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 200,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(color: Colors.grey.withAlpha(30))
              ),


              Positioned(
                top: 200,
                bottom: 0,
                left: 0,
                right: 0,

                child: FutureBuilder(
                  future: widget._dataFetched ? null : _loadProblems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                    return MediaQuery.of(context).size.width >= 690 ? buildDataTable() : SingleChildScrollView(scrollDirection: Axis.horizontal, child: buildDataTable());
                  }
                ),
              ),
            ],
          ),
        )
      ),
    );   

  }

  DataTable buildDataTable() {
    return DataTable(
      sortColumnIndex: 1,
      sortAscending: false,

      columns: [
        DataColumn(label: Text('Problem', style: GoogleFonts.nunito(fontSize: 15))),
        DataColumn(label: Text('Status', style: GoogleFonts.nunito(fontSize: 15))),
        DataColumn(label: Text('Difficulty', style: GoogleFonts.nunito(fontSize: 15))),
        DataColumn(label: Text('Category', style: GoogleFonts.nunito(fontSize: 15))),
      ],

      rows: List.generate(_problems.length, (index) =>
        DataRow(
          cells: [
            DataCell(
              GestureDetector(
                onTap: () {
                  // var uri = Uri(
                  //   path: _problems[index].problemLink, //s.replaceFirst('https://', ''),
                  // );
                  // print(uri.toString());
                  launch(_problems[index].problemLink);//uri.toString());
                },
                child: Text(
                  '${index + 1}. ${_problems[index].problemName}', 
                  style: GoogleFonts.nunito(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16)
                ),
              )
            ),
            DataCell(
              IgnorePointer(
                ignoring: _updating,

                child: ProblemStatus(
                  onChanged: (value) async {
                    var _id = _problems[index].problemID;

                    setState(() {
                      _updating = true;
                      if (value == 1) {
                        widget.solved.add(_id);
                        widget.cantSolve.removeWhere((element) => element == _id);
                      } else if (value == 2) {
                        widget.cantSolve.add(_id);
                        widget.solved.removeWhere((element) => element == _id);
                      } else {
                        widget.solved.removeWhere((element) => element == _id);
                        widget.cantSolve.removeWhere((element) => element == _id);
                      }
                    });

                    if (value == 0) {
                      await UserModel.removeSolved(_id);
                      await UserModel.removeCSolved(_id);
                    }if (value == 1) {
                      await UserModel.addSolved(_id);
                      await UserModel.removeCSolved(_id);
                    } else if (value == 2) {
                      await UserModel.addCSolved(_id);
                      await UserModel.removeSolved(_id);
                    }

                    setState(() {
                      _updating = false;
                    });
                  },
                  selected: (UserModel.solved_problems.contains(_problems[index].problemID) ? 1 : UserModel.cant_solve_problems.contains(_problems[index].problemID) ? 2 : 0),
                ),
              )
            ),
            DataCell(Text(
              '${parseDifficulty(_problems[index].difficulty)}',
              style: GoogleFonts.nunito(fontSize: 15),
            )),
            DataCell(CategorySpoiler(toPascalCase(_problems[index].category), !UserModel.solved_problems.contains(_problems[index].problemID)))// Text('${toPascalCase(_problems[index].category)}')),
          ]
        ),
      ),
    );
  }
}