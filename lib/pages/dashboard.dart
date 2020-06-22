import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/static/problemstore.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {  
  int problem_count = 0;

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
                  style: GoogleFonts.nunito(fontSize: 16)
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
                  Container(width: MediaQuery.of(context).size.width * (((UserModel.solved_problems.length ?? 0)/(ProblemStore.problem_count))), 
                  height: 15, color: Colors.green.shade600.withAlpha(165),),

                  Container(width: MediaQuery.of(context).size.width * (((UserModel.cant_solve_problems.length ?? 0)/(ProblemStore.problem_count))), 
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
                    color: Colors.black.withAlpha(200)
                  ),
                ),
              ),
            ),

            Positioned(
              top: 150,
              left: 0,
              right: 0,

              child: Center(
                child: Text('Solved: ${UserModel.solved_problems.length}/${ProblemStore.problem_count}', style: TextStyle(fontSize: 20,color: Colors.black54)),
              ),
            ),

            Positioned(
              top: 200,
              bottom: 0,
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

                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,

                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    hoverColor: Colors.grey.withAlpha(100),

                                    onTap: () {
                                      if (ProblemStore.problemsOnDay(day: i * 7 + j + 1) == null  || ProblemStore.problemsOnDay(day: i * 7 + j + 1).length == 0) return null;
                                      Navigator.pushNamed(context, '/pset/day', arguments: (i * 7 + j + 1));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Day ${i * 7 + j + 1}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            ProblemStore.problemsOnDay(day: i * 7 + j + 1) == null || ProblemStore.problemsOnDay(day: i * 7 + j + 1).length == 0
                                             ? 'Coming Soon' : "${ProblemStore.problemsOnDay(day: i * 7 + j + 1).length} problems",
                                            style: TextStyle(fontSize: 12, color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ),
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
          ],
        )
      ),
    );
  }
}