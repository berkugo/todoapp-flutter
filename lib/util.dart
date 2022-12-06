import 'package:flutter/cupertino.dart';

class Utility {

  static double getHeightOfCurrentContext(BuildContext context) {
      return MediaQuery.of(context).size.height;
  }

  static double getWidthOfCurrentContext(BuildContext context) {
      return MediaQuery.of(context).size.width;
  }


}