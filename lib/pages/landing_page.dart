import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/pages/home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  final String _lottieUrl =
      "https://assets1.lottiefiles.com/packages/lf20_ZcIjtY.json";
  final String _title = "Organize your tasks";
  final String _subTitle =
      "Make arragements or preperations for (an event or activity)";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Lottie.network(_lottieUrl, fit: BoxFit.fitHeight),
          ),
          Text(
            _title,
            textScaleFactor: 2.0,
            style: GoogleFonts.nunito(color: Colors.black),
          ),
          Text(
            _subTitle,
            textScaleFactor: 1.0,
            style: GoogleFonts.nunito(color: Colors.black45),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Home()));
                  },
                  child: Text("Get Started",
                      style: GoogleFonts.nunito(color: Colors.white))))
        ],
      ),
    );
  }
}
