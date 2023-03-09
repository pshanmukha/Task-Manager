import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/constants/constants.dart';

Widget taskTile(Size size) {
  bool _isCompleted = true;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Card(
      child: ListTile(
        leading: _isCompleted ? Icon(Icons.check_circle_outline,color: checkIcon,): null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Submit',
              style: GoogleFonts.robotoMono(
                fontSize: 20,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.edit_square,color: checkIcon,fill: 0.0,),onPressed: () {},),
                IconButton(icon: Icon(Icons.delete,color: deleteIcon,),onPressed: () {},),
              ],
            )
          ],
        ),
        onTap: () {},
      ),
    ),
  );
}
