import 'package:flutter/material.dart';
import '../../../themeUI/ui.dart';

class PrimaryButton extends StatelessWidget {
  final  String text;
  final Function()? onPressed;
  final Color? backGroundColor;
  final double? borderRadius;
  const PrimaryButton({super.key,required this.text,this.onPressed,this.borderRadius=1,this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor:backGroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 25),
          )
      ),
    );
     }
}
