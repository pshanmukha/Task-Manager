import 'package:flutter/material.dart';
import 'package:task_manager/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'package:task_manager/services/dio_client.dart';
import 'package:task_manager/widgets/historytile_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();

  late DioClient dioClient;
  late Future<Tasks> _tasksList;
  bool isLoading = false;
  bool isTaskCreated = false;

  @override
  void initState() {
    dioClient = DioClient();
    getTasks();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  getTasks() {
    _tasksList = dioClient.fetchTasks();
  }

  ScaffoldMessengerState showSnackBar(
      {required String text, required Color backgroundColor}) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: backgroundColor,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Task Manager",
                      style: GoogleFonts.robotoMono(
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length <= 2) {
                              return 'Please enter valid text';
                            } else if (value.length >= 20) {
                              return 'Text cant be more than 20 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: textFormFieldBackground,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(5.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(5.5),
                            ),
                            hintText: "e.g. wash dishes",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint("validated ${_nameController.text}");
                          setState(() {
                            isLoading = true;
                          });
                          isTaskCreated = await dioClient.createTask(
                              name: _nameController.text.toString());
                          if (isTaskCreated) {
                            getTasks();
                            showSnackBar(
                              text: "Success!, Task created..",
                              backgroundColor: backButton,
                            );
                          } else {
                            showSnackBar(
                              text: "Failure!, Something went wrong..",
                              backgroundColor: deleteIcon,
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: !isLoading
                          ? Text(
                              'Submit',
                              style: GoogleFonts.robotoMono(
                                fontSize: 20,
                              ),
                            )
                          : const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder(
                future: _tasksList,
                builder: (BuildContext context, AsyncSnapshot<Tasks> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError || snapshot.data == null) {
                      return Text(snapshot.data == null
                          ? 'There is something wrong!'
                          : '${snapshot.hasError}');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.tasks.length,
                      itemBuilder: (context, index) {
                        return taskTile(
                            size, context, snapshot.data!.tasks[index]);
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
