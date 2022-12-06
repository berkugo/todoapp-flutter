import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/http/http_client.dart';
import 'package:todoapp/models/TodoModel.dart';
import 'package:todoapp/util.dart';

import 'add_todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now = DateTime.now();
  late DateTime date;

  @override
  void initState() {
    date = DateTime(now.year, now.month, now.day);
    HttpClient.makeGetRequest().then((value) => print("Data fetched."));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.green,
            onPressed: (() {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTodo()));
            }),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: buildCont(context));
  }

  Container buildCont(BuildContext context) {
    return Container(
          margin: EdgeInsets.symmetric(
              vertical: Utility.getHeightOfCurrentContext(context) / 8,
              horizontal: Utility.getWidthOfCurrentContext(context) / 10),
          height: Utility.getHeightOfCurrentContext(context),
          width: Utility.getWidthOfCurrentContext(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Let's be productive today",
                textScaleFactor: 1.5,
              ),
              Text(
                  "Today's date - ${date.day.toString()}/${date.month.toString()}/${date.year.toString()}",
                  textScaleFactor: 1),
              SizedBox(
                  height: Utility.getHeightOfCurrentContext(context) / 2,
                  child: TodoModel.instances.length != 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: TodoModel.instances.length,
                          itemBuilder: (context, i) {
                            return buildTodoContainer(context, i);
                          })
                      : Lottie.network(
                          "https://assets1.lottiefiles.com/private_files/lf30_e3pteeho.json"))
            ],
          ));
  }

  Container buildTodoContainer(BuildContext context, int i) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: Utility.getHeightOfCurrentContext(context) / 8,
      decoration: BoxDecoration(
          color: Color.fromARGB(70, 140, 255, 146),
          border: Border.all(color: Colors.transparent, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        leading: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
        subtitle: Text("Deadline at - ${TodoModel.instances[i].deadline}"),
        title: Text(
          TodoModel.instances[i].title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
