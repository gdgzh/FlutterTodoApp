import 'dart:async';

import 'package:flutter/material.dart';
import 'todo_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber[600],
        ),
        home: MyHomePage(title: 'TODO App'),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.title}) : assert(title != null);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _todoList = <String>[
    'Create Flutter project',
    'Create TODO item',
    'Something',
    'Example',
  ];

  Future<String> _addTodoItemDialog() async {
    final TextEditingController _textController = TextEditingController();
    return await showDialog<String>(
        context: context,
        // User must tap a button to dismiss dialog
        barrierDismissible: false,
        builder: (context) => SimpleDialog(
              title: const Text('Add your task'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    autofocus: true,
                    controller: _textController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: const Text('ADD'),
                      onPressed: () {
                        setState(() {
                          _todoList.add(_textController.text.trim());
                          Navigator.of(context).pop(null);
                        });
                      },
                    ),
                    FlatButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pop(null);
                      },
                    )
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.redAccent,
                ),
                onDismissed: (direction) {
                  setState(() {
                    _todoList.removeAt(index);
                  });
                },
                child: TodoItem(
                  text: _todoList[index],
                ),
              ),
          itemCount: _todoList.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTodoItemDialog,
          child: Icon(Icons.add),
        ),
      );
}
