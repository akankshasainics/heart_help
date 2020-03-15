import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
List model_data = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
void main() {
  
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'heart disease prediction',
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
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

class SinglePage extends StatelessWidget {
  final Widget child;
  final bool isEnd;
  final Color color;
  SinglePage(this.child, {this.color = Colors.grey, this.isEnd = false});
  @override
  Widget build(BuildContext context) {
    if (this.isEnd) {
      return Container(
        color: this.color,
        child: Center(
          child: Card(
            elevation: 15,
            child: Padding(
              child: this.child,
              padding: EdgeInsets.all(15),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: this.color,
        child: Column(children: [
          Spacer(
            flex: 6,
          ),
          Card(
            margin: EdgeInsets.all(15),
            elevation: 15,
            child: Padding(
              child: this.child,
              padding: EdgeInsets.all(15),
            ),
          ),
          Spacer(
            flex: 5,
          ),
          Row(children: [
            Spacer(
              flex: 8,
            ),
            Icon(
              Icons.arrow_forward_ios,
            ),
            Spacer(),
          ]),
          Spacer()
        ]),
      );
    }
  }
}

class DateForm extends StatefulWidget {
  @override
  _DateState createState() {
    return _DateState();
  }
}

class _DateState extends State<DateForm> {
  DateTime _dateTime;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        Text(
          'DOB: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        Spacer(
          flex: 1,
        ),
        Text(
          _dateTime == null ? '' : this._dateTime.toString().substring(0, 10),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        Spacer(
          flex: 5,
        ),
        Center(
          child: RaisedButton(
            color: Colors.teal[50],
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.calendar_today,
                color: Colors.teal,
              ),
            ),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime(1995),
                firstDate: DateTime(1920),
                lastDate: DateTime(2020),
              ).then((data) {
                this._dateTime = data;
                this.setState(() => {});
                model_data[0] = data;
              });
            },
          ),
        ),
      ],
    );
  }
}

class Gender extends StatefulWidget {
  @override
  _GenderForm createState() {
    return _GenderForm();
  }
}

class _GenderForm extends State<Gender> {
  int group = 1;
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 7.5),
            child: Text(
              'Gender:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            children: <Widget>[
              Radio(
                activeColor: Colors.teal[500],
                value: 0,
                groupValue: group,
                onChanged: (T) {
                  print(T);

                  this.setState(() {
                    group = T;
                  });

                  model_data[1] = T ? 2 : 1;
                },
              ),
              Text('Male'),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                activeColor: Colors.teal[500],
                value: 1,
                groupValue: group,
                onChanged: (T) {
                  print(T);
                  this.setState(() {
                    group = T;
                  });
                  model_data[1] = T? 2:1;
                },
              ),
              Text('Female'),
            ],
          ),
        ],
      ),
    );
  }
}

class FirstForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[DateForm(), Gender()],
    );
  }
}

class MyPage extends StatelessWidget {
  PageController controller = PageController();
  @override
  Widget build(BuildContext buildContext) {
    return PageView(
      controller: controller,
      onPageChanged: (page){
        print(model_data[0]);
        if(model_data[0]==-1){
          this.controller.animateToPage(1, duration: Duration(microseconds: 200), curve: ElasticInCurve());
        }
      },
      dragStartBehavior: DragStartBehavior.start,
      // controller: PageController(viewportFraction: 0.9),
      children: <Widget>[
        SinglePage(
          Text(
            'HELLO!',
            style: TextStyle(fontSize: 40, color: Colors.grey[700]),
          ),
          color: Colors.grey[600],
        ),
        SinglePage(FirstForm(), color: Colors.teal),
        SinglePage(
          Text('Bye!'),
          color: Colors.blueGrey,
          isEnd: true,
        )
      ],
    );
  }
}
