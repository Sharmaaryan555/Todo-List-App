import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _tasks = [];
// hello 
  void _addNewTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _updateTask(int index, String updatedTask) {
    setState(() {
      _tasks[index] = updatedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _showTaskDialog({String? initialTask, int? taskIndex}) {
    String taskText = initialTask ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(taskIndex == null ? "Add Task" : "Edit Task"),
          content: TextField(
            onChanged: (value) => taskText = value,
            controller: TextEditingController(text: initialTask),
            decoration: InputDecoration(hintText: "Enter task..."),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(taskIndex == null ? "Add" : "Update"),
              onPressed: () {
                if (taskText.isNotEmpty) {
                  if (taskIndex == null) {
                    _addNewTask(taskText);
                  } else {
                    _updateTask(taskIndex, taskText);
                  }
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List"),
       centerTitle: true),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            taskName: _tasks[index],
            onEdit:
                () => _showTaskDialog(
                  initialTask: _tasks[index],
                  taskIndex: index,
                ),
            onDelete: () => _deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
