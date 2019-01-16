import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter ToDo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ToDo {
  String title = "";
  bool value = false;
  ToDo(String _title, bool _value) {
    title = _title;
    value = _value;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> _todoItems = [
    new ToDo("task1", false),
    new ToDo("task2", false),
    new ToDo("task3", true)
  ];
  
  bool _value1 = false;
  void _addToDo(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(new ToDo(task, false));
      });
    }
  }


  void _onChecked(bool value) => setState(() => _value1 = value);

  Widget _buildToDoItem(BuildContext _context, ToDo todo) {
    return new Dismissible(
      key: Key(todo.title),
      onDismissed: (direction) {
                // Remove the item from our data source.
                setState(() {
                  _todoItems.remove(todo);
                });

                // Then show a snackbar!
                Scaffold.of(_context)
                    .showSnackBar(SnackBar(content: Text("Task dismissed")));
              },
        background: Container(color: Colors.red),
        child: Row(
        children: <Widget>[
          Checkbox(
            value: todo.value,
            onChanged: (bool newValue) => setState(() =>
              todo.value = newValue
            ),
            activeColor: Colors.red,
          ),
          Text(todo.title),
        ],
      ),
    ); 
  }

  Widget _buildToDoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _todoItems.length) {
          return _buildToDoItem(context, _todoItems[index]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildToDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddToDoScreen,
        tooltip: 'Add ToDo',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _pushAddToDoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task'),
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addToDo(val);
              Navigator.pop(context);
            },
          ));
    }));
  }
}
