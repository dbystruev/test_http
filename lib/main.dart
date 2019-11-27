import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'show_code.dart';

class TestHttp extends StatefulWidget {
  final String url;

  TestHttp({String url}) : url = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
} // TestHttp

class TestHttpState extends State<TestHttp> {
  String _url, _body;
  int _status;

  @override
  void initState() {
    _url = widget.url;
    super.initState();
  } //initState

  _sendRequestGet() {
    //update form data
    http.get(_url).then((response) {
      _status = response.statusCode;
      _body = response.body;

      setState(() {}); //reBuildWidget
    }).catchError((error) {
      _status = 0;
      _body = error.toString();

      setState(() {}); //reBuildWidget
    });
  } //_sendRequestGet

  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        RaisedButton(
            child: Text('See picture of the day'), onPressed: _sendRequestGet),
        SizedBox(height: 20.0),
        Text('Response status',
            style: TextStyle(fontSize: 20.0, color: Colors.blue)),
        Text(_status == null ? '' : _status.toString()),
        SizedBox(height: 20.0),
        Text('Response body',
            style: TextStyle(fontSize: 20.0, color: Colors.blue)),
        Text(_body == null ? '' : _body),
      ],
    )));
  } //build
} //TestHttpState

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test HTTP API'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.code),
                tooltip: 'Code',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CodeScreen()));
                })
          ],
        ),
        body: TestHttp(
            url: 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY'));
  }
}

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
