import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/constants/constants.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'package:task_manager/screens/edittask_screen.dart';
import 'package:task_manager/services/dio_client.dart';
import 'package:task_manager/widgets/utils.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({Key? key, required this.size, required this.task, required this.onReachMainScreen}) : super(key: key);
  final Size size;
  final Task task;
  final VoidCallback onReachMainScreen;
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _isCompleted = false;
  bool isLoading = false;
  bool isTaskDeleted = false;
  late DioClient dioClient;

  @override
  void initState() {
    _isCompleted = widget.task.completed;
    dioClient = DioClient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.size.width * 0.02),
      child: Card(
        child: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(milliseconds: 500),
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return ListTile(
              leading: _isCompleted ? Icon(Icons.check_circle_outline,color: checkIcon,) : Icon(Icons.unpublished_outlined,color: deleteIcon,),
              title: Text(
                widget.task.name,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.robotoMono(
                  fontSize: 20,
                  decoration: _isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: IconButton(icon: Icon(Icons.delete,color: deleteIcon,),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  isTaskDeleted = await dioClient.deleteTask(taskID: widget.task.id);
                  if (isTaskDeleted) {
                    widget.onReachMainScreen();
                    showSnackBar(
                      text: "Success!, Task deleted..",
                      backgroundColor: backButton,
                      context: context,
                    );
                  } else {
                    showSnackBar(
                      text: "Failure!, Something went wrong..",
                      backgroundColor: deleteIcon,
                      context: context,
                    );
                  }

                  setState(() {
                    isLoading = false;
                  });
              },),
            );
          },
          openBuilder: (BuildContext _, VoidCallback __) {
            return  EditTaskScreen(taskID: widget.task.id,);
          },
          onClosed: (_) {
            print("before called");
            widget.onReachMainScreen();
            print("after called");
          },
        ),
      ),
    );
  }
}


/*Widget taskTile(Size size, BuildContext context, Task task) {
  bool _isCompleted = task.completed;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Card(
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 500),
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return ListTile(
            leading: _isCompleted ? Icon(Icons.check_circle_outline,color: checkIcon,) : Icon(Icons.unpublished_outlined,color: deleteIcon,),
            title: Text(
              task.name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.robotoMono(
                fontSize: 20,
                decoration: _isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(icon: Icon(Icons.delete,color: deleteIcon,),onPressed: () {},),
          );
        },
        openBuilder: (BuildContext _, VoidCallback __) {
          return  EditTaskScreen(taskID: task.id,);
        },
        onClosed: (_) => print('Closed'),
      ),
    ),
  );
}*/
