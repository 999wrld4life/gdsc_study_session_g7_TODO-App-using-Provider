import 'package:flutter/material.dart';
import 'package:project_1/create_task.dart';
import 'package:project_1/model/task_model.dart';
import 'package:project_1/provider/crud_provider.dart';
import 'package:provider/provider.dart';

Widget taskList(TaskModel task, BuildContext context) {
  String firstChar = task.title.isNotEmpty ? task.title[0].toUpperCase() : '';

  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(15),
        width: 390,
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
          ],
        ),
        child: Row(
          children: [
            Text(
              firstChar,
              style: const TextStyle(
                fontSize: 27,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              height: 40,
              width: 4,
              color: Colors.red,
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return CreateTask(editingTask: task);
                      }),
                    );
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Provider.of<CrudManager>(context, listen: false)
                        .taskDone(task);
                  },
                  child: Icon(
                    Icons.done_all_outlined,
                    color: task.isDone ? Colors.deepOrange : Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Provider.of<CrudManager>(context, listen: false)
                        .removeFromTasks(task);
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
