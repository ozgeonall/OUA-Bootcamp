import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'To-Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> tasks = [];
  List<bool> taskStatus = [];
  TextEditingController taskController = TextEditingController();

  void _addTask() {
    setState(() {
      String newTask = taskController.text.trim();
      if (newTask.isNotEmpty) {
        tasks.add(newTask);
        taskStatus.add(false);
        taskController.clear();
      }
    });
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
      taskStatus.removeAt(index);
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      taskStatus[index] = !taskStatus[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            value: taskStatus[index],
            onChanged: (value) => _toggleTaskStatus(index),
            title: Text(tasks[index]),
            controlAffinity: ListTileControlAffinity.leading,
            secondary: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Görev Ekle'),
              content: TextField(
                controller: taskController,
                decoration:
                    const InputDecoration(hintText: 'Yapılacak görev...'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('İptal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTask();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ekle'),
                ),
              ],
            );
          },
        ),
        tooltip: 'Görev Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
