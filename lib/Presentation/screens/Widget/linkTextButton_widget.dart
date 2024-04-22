import 'package:flutter/material.dart';


class LinkButton extends StatelessWidget {
  final  String text;
  final Function()? onPressed;
  final Color? color;
  const LinkButton({super.key,required this.text,this.onPressed,this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,style: TextButton.styleFrom(
      padding: EdgeInsets.zero
    ),
        child: Text(
          text,
          style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ));
  }
}
