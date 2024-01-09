import 'package:flutter/material.dart';
import 'package:project_1/model/task_model.dart';
import 'package:project_1/provider/crud_provider.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  final TaskModel? editingTask;
  const CreateTask({super.key, this.editingTask});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

late TextEditingController titleController;
late TextEditingController dateController;
late TextEditingController descController;

class _CreateTaskState extends State<CreateTask> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Initialize controllers based on whether it's a new task or editing existing
    titleController = TextEditingController(
        text: widget.editingTask?.title ??
            ''); // Provide default value if editing
    dateController = TextEditingController(
        text:
            widget.editingTask?.date ?? ''); // Provide default value if editing
    descController = TextEditingController(
        text: widget.editingTask?.description ??
            ''); // Provide default value if editing
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Create New Task",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 10, thickness: 1, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Main Task Name',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ], // Shadow
                  ),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your task here...',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field Empty. Enter your task!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Due date',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ], // Shadow
                  ),
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter the date here (YYYY-MM-DD)...',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')
                              .hasMatch(value)) {
                        return "Invalid date format";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ], // Shadow
                  ),
                  child: TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your description here...'),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(fontSize: 18),
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description is empty. Enter description of the task";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.editingTask != null) {
                          // If editing an existing task, update it
                          Provider.of<CrudManager>(context, listen: false)
                              .updateTask(
                            widget.editingTask!,
                            TaskModel(
                              title: titleController.text,
                              date: dateController.text,
                              description: descController.text,
                            ),
                          );
                          final snackBar = SnackBar(
                            content: Text('Task Updated'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          // If not editing, add a new task
                          Provider.of<CrudManager>(context, listen: false)
                              .addToTasks(
                            TaskModel(
                              title: titleController.text,
                              date: dateController.text,
                              description: descController.text,
                            ),
                          );
                          final snackBar = SnackBar(
                            content: Text('Task Created'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      titleController.clear();
                      dateController.clear();
                      descController.clear();
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    child: const Text(
                      'Add Task',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
