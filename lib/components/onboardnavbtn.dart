import 'package:bloom/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({Key? key, required this.name, required this.OnPressed}) : super(key: key);
  final String name;
  final VoidCallback OnPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: OnPressed,
        borderRadius: BorderRadius.circular(6),
        splashColor: Colors.black12,
        child:Padding(
            padding: const EdgeInsets.all(4.0),
            child:Text(
              name,
              style: kBodyText1,
            )
        )
    );
  }
}
