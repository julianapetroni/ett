import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonDecoration extends StatelessWidget {
  String buttonTitle;
  bool shouldHaveIcon;
  IconData icon;
  var sizedBox;
  Function onPressed;

  ButtonDecoration(
      {@required this.buttonTitle,
      this.shouldHaveIcon,
      this.icon,
      this.sizedBox,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: FlatButton(
          onPressed: onPressed,
          textColor: Colors.white,
          child: Container(
            width: double.infinity,
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.grey[900],
                  Colors.grey[700],
                  Colors.grey[400],
                ],
              ),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: shouldHaveIcon,
                  child: Stack(
                    children: [
                      Icon(icon),
                      SizedBox(
                        width: sizedBox,
                      ),
                    ],
                  ),
                ),
                Text(
                  buttonTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.white, letterSpacing: 1),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
