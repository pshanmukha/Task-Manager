import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/constants/constants.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  bool isCompleted = false;
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        "Edit Task",
                        style: GoogleFonts.robotoMono(
                          textStyle:
                          Theme.of(context).textTheme.headlineLarge,
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
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Name',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Completed',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: Checkbox(
                                    value: isCompleted,
                                    activeColor: Colors.purple,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value){
                                      setState(() {
                                        isCompleted = value!;
                                      });
                                    }
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("validated ${_nameController.text}");
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
                        child: Text(
                          'Edit',
                          style: GoogleFonts.robotoMono(
                            fontSize: 20,
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
            ],
          ),
        ),
      ),
    );
  }
}
