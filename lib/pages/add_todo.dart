import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/models/TodoModel.dart';
import 'package:todoapp/util.dart';

import '../http/http_client.dart';
import 'home.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  bool _valid = false;
  String _selectedDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Add Todo"),
            automaticallyImplyLeading: true),
        body: Container(
          height: Utility.getHeightOfCurrentContext(context),
          width: Utility.getWidthOfCurrentContext(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(), onConfirm: (date) {
                      _selectedDate = date.toString();
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Click here to enter your deadline',
                    style: TextStyle(color: Colors.black),
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                    // Tell your textfield which controller it owns
                    controller: titleController,
                    // Every single time the text changes in a
                    // TextField, this onChanged callback is called
                    // and it passes in the value.
                    //
                    // Set the text of your controller to
                    // to the next value.
                    onChanged: (v) => print(v),
                    decoration: InputDecoration(
                      errorText: _valid ? null : "You have to enter a title.",
                      fillColor: Colors.green,
                      labelText: 'Enter Todo Title',
                    )),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: OutlinedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          _valid = true;
                          TodoModel model = TodoModel.createInstance(
                              titleController.text, _selectedDate);
                          HttpClient.makePostRequest(model).then((value) {
                            if (value) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Home()));
                            }
                          });
                        } else {
                          _valid = false;
                        }
                      },
                      child: Text("Add Todo",
                          style: GoogleFonts.nunito(color: Colors.white))))
            ],
          ),
        ));
  }
}
