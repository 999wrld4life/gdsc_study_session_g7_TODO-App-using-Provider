import 'package:flutter/material.dart';
import 'package:project_1/components/task_list.dart';
import 'package:project_1/create_task.dart';
import 'package:project_1/provider/crud_provider.dart';
import 'package:provider/provider.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    var currentTask = Provider.of<CrudManager>(context).tasks;
    return Scaffold(
      appBar: AppBar(
          title: const Text('ToDO List'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: const Color.fromARGB(255, 211, 108, 25),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, size: 45),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('resources/stickman.png', height: 180),
              const Text(
                'Tasks List',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                  itemCount: Provider.of<CrudManager>(context).tasks.length,
                  itemBuilder: ((context, index) {
                    return taskList(currentTask[index], context);
                  }),
                ),
              ),
              // taskList(),
              // const SizedBox(height: 10),
              // taskList(),
              // const SizedBox(height: 10),
              // taskList(),
              // const SizedBox(height: 10),
              // taskList(),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const CreateTask();
                    }),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Colors.red),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(200.0, 40.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    )),
                child: const Text(
                  "Create Task",
                  style: TextStyle(
                    color: Colors.white,
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
