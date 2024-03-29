import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/static/problemstore.dart';
import 'package:psettracker/static/settings.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {  
  int problem_count = 0;
  int solved_count = UserModel.solved_problems.length;
  int cant_solve_count = UserModel.cant_solve_problems.length;

  _updateState(a, b) {
    print(UserModel.solved_problems.length);
    print(UserModel.cant_solve_problems.length);
    setState(() {
      solved_count = a;
      cant_solve_count = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PageWrapper(        
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(color: Colors.grey.withAlpha(20), height: 800,),
            ),

            Positioned(
              right: 25,
              top: 25,
              child: MaterialButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, '/login/loginpage');
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: Settings.darkTheme ? Colors.white70 : Colors.black
                  )
                )
              ),
            ),

            Positioned(
              top: 20,
              left: 25,

              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            Positioned(
              top: 63,
              left: 27,

              child: Text(
                '${ProblemStore.problemset_count} problemsets available',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            Positioned(
              top: 185,
              left: 0,
              child: Row(
                children: [
                  Container(width: MediaQuery.of(context).size.width * (((solved_count ?? 0)/(ProblemStore.problem_count))), 
                  height: 15, color: Colors.green.shade600.withAlpha(165),),

                  Container(width: MediaQuery.of(context).size.width * (((cant_solve_count ?? 0)/(ProblemStore.problem_count))), 
                  height: 15, color: Colors.red.shade600.withAlpha(165),),
                ],
              ) 
            ),

            Positioned(
              top: 185,
              left: 0,
              right: 0,
              child: Container(width: double.infinity, height: 15, color: Colors.grey.withAlpha(65),),
            ),

            Positioned(
              top: 110,
              left: 0,
              right: 0,

              child: Center(
                child: Text(
                  UserModel.username,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Settings.darkTheme ? Colors.white : Colors.black.withAlpha(200)
                  ),
                ),
              ),
            ),

            Positioned(
              top: 150,
              left: 0,
              right: 0,

              child: Center(
                child: Text(
                  'Solved: ${solved_count}/${ProblemStore.problem_count}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Settings.darkTheme ? Colors.white60 : Colors.black54
                  )
                ),
              ),
            ),

            Positioned(
              top: 200,
              bottom: 30,
              left: 0,
              right: 0,

              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: List.generate(4, (i) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '    Week ${i + 1}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Wrap(
                            children: List.generate(7, (j) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 200,
                                height: 70,

                                child: FlatButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    if (ProblemStore.problemsOnDay(day: i * 7 + j + 1) == null  || ProblemStore.problemsOnDay(day: i * 7 + j + 1).length == 0) return null;
                                    Navigator.pushNamed(context, '/pset/day', arguments: { 'day': (i * 7 + j + 1), 'callback': _updateState });
                                  },

                                  color: Settings.darkTheme ? Colors.black54 : Colors.white,
                                  hoverColor: Colors.black12,
                                  padding: EdgeInsets.zero,

                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Day ${i * 7 + j + 1}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Settings.darkTheme ? Colors.white60 : Colors.black87
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            ProblemStore.problemsOnDay(day: i * 7 + j + 1) == null || ProblemStore.problemsOnDay(day: i * 7 + j + 1).length == 0
                                             ? 'Coming Soon' : "${ProblemStore.problemsOnDay(day: i * 7 + j + 1).length} problems",
                                            style: TextStyle(
                                              fontSize: 12, 
                                              color: Settings.darkTheme ? Colors.white54 : Colors.black45
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              )
                            ))
                          ),
                          const SizedBox(height: 20)
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,

              child: Container(
                color: Colors.black87, height: 30,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () { Navigator.pushNamed(context, '/about/contributors'); },
                        child: Text('Contributors', style: GoogleFonts.nunito(color: Colors.white),),
                      ),
                      FlatButton(
                        onPressed: () { Navigator.pushNamed(context, '/about/about'); },
                        child: Text('About', style: GoogleFonts.nunito(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}