import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
    _saveData(new Todo(false, "Todo $_counter"));
    _loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

_loadData() async {
  var url = "https://flutter-api-8decd.firebaseio.com/todo.json";
  var response = await http.get(url);
  print('response=' + response.body);


}

const jsonCodec = const JsonCodec();

_saveData(Todo todo) async {
  var json = jsonCodec.encode(todo);
  print("json=$json");

    var url = "https://flutter-api-8decd.firebaseio.com/todo.json";
    var response = await http.post(url, body: json);
    print('response=' + response.body);

}

class Todo{
  bool finished;
  String name;

  Todo(this.finished, this.name);

  Map toJson(){
    return {"finished":finished, "name":name};
  }
}