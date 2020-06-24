import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/static/settings.dart';
import 'package:psettracker/widgets/customback.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class Contributor {
  String heading, subtitle;
  Contributor(this.heading, this.subtitle);
}

class Contributors extends StatelessWidget {

  final List<Contributor> _contributors = [
    Contributor('Yashwant Singh', 'CSE, DSCE'),
    Contributor('Piyush Lakhotiya', ' '),
    Contributor('Brijesh Anand', ' '),
    Contributor('Prakhar Tibrewal', ' '),
    Contributor('Deepanshu Kumar Pali', 'CSE, DSCE'),
    Contributor('Aman Anand', 'CSE, DSCE'),
    Contributor('Ravishek Kumar Ranjan', 'CSE, DSCE'),
    Contributor('Hariom Chaturvedi', 'CSE, DSCE'),
    Contributor('Shreyas Bhakta', 'CSE, DSCE'),
    Contributor('Pranshu Pandey', 'CSE, DSCE'),
  ];


  @override
  Widget build(BuildContext context) {
    var _c = _contributors;
    _c.sort((a, b) => a.heading.compareTo(b.heading));

    return WillPopScope(
      onWillPop: () => Future.value(false),
      
      child: PageWrapper(
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 10,

              child: CustomBack(null)
            ),
            
            Positioned(
              top : 17,
              left: 60,
              child: Text(
                'Contributors',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            Positioned(
              top: 150,
              left: 30,
              right: 20,
              bottom: 10,

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Created and Maintained by'),
                        Text('Soumya Pattanayak', style: GoogleFonts.nunito(fontSize: 20)),
                        Text('CSE, DSCE', style: GoogleFonts.nunito(fontSize: 14, color: Settings.darkTheme ? Colors.white54 : Colors.black54)),
                      ],
                    ),
                    
                    const SizedBox(height:50),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Problemset contributed by'),
                        Text('Mohit Agarwal', style: GoogleFonts.nunito(fontSize: 20)),
                        Text('CSE, DSCE', style: GoogleFonts.nunito(fontSize: 14, color: Settings.darkTheme ? Colors.white54 : Colors.black54)),
                      ],
                    ),

                    const SizedBox(height:50),
                    Text('This project would not be possible without'),
                    const SizedBox(height:10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(_c.length, (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_c[index].heading, style: GoogleFonts.nunito(fontSize: 18)),
                          Text(_c[index].subtitle, style: GoogleFonts.nunito(fontSize: 14, color: Settings.darkTheme ? Colors.white54 : Colors.black54)),
                          const SizedBox(height: 30),
                        ],
                      ))
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}