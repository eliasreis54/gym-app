import 'package:flutter/material.dart';
import './todoList.dart';
import './requests.dart';
import './exercises.dart';
import 'dart:convert';

class TodoListState extends State<TodoList> {
  List<dynamic> _todoItems = [];

  void fetchData() async {
    Requests r = new Requests();
    final responde = await r.fetchExercises();
    if (responde.statusCode == 200) {
      Exercises e = Exercises.fromJson(json.decode(responde.body));
      e.monday.forEach((item) => setState(() => _todoItems.add(item)));
      e.monday.forEach((item) => print(item));
    }
  }

  void _addItem(String text) {
    setState(() {
      _todoItems.add(text);
    });
  }

  void _removeItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  Widget _dropDownDays() {
    return DropdownButton<String>(
        value: '',
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.deepPurple
        ),
        underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            print(newValue);
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
          );
        })
    .toList(),
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(
        itemBuilder: (context, index) {
          if (index < _todoItems.length) {
            return _buildTodoItem(_todoItems[index], index);
          }
        }
      );
  }

    Widget _buildTodoItem(String todoText, int index) {
      return new ListTile(
          title: new Text(todoText),
          onTap: () => _promptRemoveTodoItem(index),
      );
    }

  void _pushAddTodoScreen() {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute(
      builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task')
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
      }
    )
  );
  }

  void _promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Mark "${_todoItems[index]}" as done?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              _removeItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
  );
  }

  @override
  Widget build(BuildContext context) {
    final ret = new Scaffold(
        appBar: new AppBar(
            title: new Text('Gym todo')
        ),
        // body: Text('ola mundo'),
        body: Column(
            children: <Widget>[
              Text('teste'),
              Expanded(
                  child: Container(
                    child: _buildTodoList()
                  )
              )
            ]
        ),
        floatingActionButton: new FloatingActionButton(
            onPressed: _pushAddTodoScreen,
            tooltip: 'Add task',
            child: new Icon(Icons.add)
            )
      );
    return ret;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
}
