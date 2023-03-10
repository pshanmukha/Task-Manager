import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/constants/constants.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'package:task_manager/screens/edittask_screen.dart';

Widget taskTile(Size size, BuildContext context, Task task) {
  bool _isCompleted = task.completed;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Card(
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedBuilder: (BuildContext context,
            VoidCallback openContainer) {
          return ListTile(
            leading: _isCompleted ? Icon(Icons.check_circle_outline,color: checkIcon,) : Icon(Icons.unpublished_outlined,color: deleteIcon,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.name,
                  style: GoogleFonts.robotoMono(
                    fontSize: 20,
                    decoration: _isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.edit_square,color: checkIcon,fill: 0.0,),onPressed: () {
                      /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditTaskScreen()),
                    );*/
                      openContainer();
                    },),
                    IconButton(icon: Icon(Icons.delete,color: deleteIcon,),onPressed: () {},),
                  ],
                )
              ],
            ),
          );
        },
        openBuilder: (BuildContext _, VoidCallback __) {
          return const EditTaskScreen();
        },
        onClosed: (_) => print('Closed'),
      ),
    ),
  );
}
