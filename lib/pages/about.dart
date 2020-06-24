import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/widgets/customback.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'About',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            Positioned(
              top: 170,
              left: 0,
              right: 0,

              child: Center(
                child: Column(
                  children: [
                    Text(
                      "<. >", 
                      style: GoogleFonts.ptMono(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                        fontSize: 34
                      ),
                    ),
                    Text(
                      "Point Blank", 
                      style: GoogleFonts.ptMono(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                        fontSize: 34
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [                                      
                        Text(
                          "Problemsets", 
                          style: GoogleFonts.ptMono(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 22
                          ),
                        ),
                        Text(
                          " alpha", 
                          style: GoogleFonts.ptMono(
                            color: Colors.grey.withAlpha(150),
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),                                    
                    Container(
                      width: 250,
                      child: Text(
                        "A tracking tool to track progress in coding problems",
                        style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 50),                                    
                    Container(
                      width: 250,
                      child: Text(
                        "All problems belong to their respective copyright owners. Point Blank and any contributors of this app are not the authors and do not own any problems. This app is provided ​“AS IS” and makes no warranties, express or implied, and hereby disclaims all implied warranties, including any warranty of merchantability and warranty of fitness for a particular purpose.",
                        style: GoogleFonts.nunito(
                          color: Colors.grey.withAlpha(60),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}