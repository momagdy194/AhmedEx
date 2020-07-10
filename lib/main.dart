import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

final GlobalKey<FormBuilderState> keyEX = GlobalKey<FormBuilderState>();
Authantication authantication = Authantication();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FormBuilder(
        key: keyEX,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('xxxxxxxxxxxxxxxxxxxxxxxx'),
            FormBuilderTextField(
              attribute: 'uniec',
              validators: [],
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'mony',
              ),
            ),
            RaisedButton(onPressed: () async {
              if (keyEX.currentState.validate()) {
                keyEX.currentState.save();
                var cStateValue = keyEX.currentState.value;
                print(cStateValue['uniec']);

                await authantication.register(makeMony:cStateValue['uniec'] );
                Navigator.push(context, MaterialPageRoute(builder: (cnx) {
                  return MyHomePage();
                }));
              }
            })
          ],
        ),
      ), //
    );
  }
}

class Authantication {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<User> register({makeMony}) async {
    Map<String, String> body = {
      "makeMony": makeMony,
    };

    http.Response response = await http.post('wwwwwwwwwwwwwwwwwwwwwww',
        headers: headers, body: body);
    print(response.statusCode);
    switch (response.statusCode) {
      case 201:
        var body = jsonDecode(response.body);
        var data = body['data'];
        return User.fromJson(data);
    }
  }
}

class User {
  User.fromJson(Map<String, dynamic> x) {}
}
