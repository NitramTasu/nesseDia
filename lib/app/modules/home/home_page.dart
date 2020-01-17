import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeController = HomeController();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    print(new DateFormat.MMMM().format(new DateTime.now()));
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    //if (picked != null && picked != selectedDate)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Selecione um dia"),
                onPressed: () => {_selectDate(context)},
              ),
              RaisedButton(
                child: Text("Request"),
                onPressed: () =>
                    {homeController.searchByThisDay("1 de janeiro")},
              ),
              Observer(
                builder: (_) => Text('${homeController.text}'),
              )
            ],
          ),
        ));
  }
}
