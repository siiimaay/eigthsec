import 'package:flutter/material.dart';

class RoundedRaisedButton extends StatelessWidget {
  const RoundedRaisedButton({
    Key key,
    @required this.size,
    this.text,
    this.icon,
    this.press,
  }) : super(key: key);

  final Size size;
  final String text;
  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.6,
      child: RaisedButton(
        onPressed: press,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              icon,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}