import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeController = HomeController();
  final _formKey = GlobalKey<FormState>();
  String _day = '1';
  final List<String> _months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  String _selectMonth;
  String _selectedMonth = "Janeiro";

  // Future<Null> _selectDate(BuildContext context) async {
  //   print(new DateFormat.MMMM().format(new DateTime.now()));
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              getForm(),
              Observer(
                builder: (_) => Text('${homeController.text}'),
              )
            ],
          ),
        ));
  }

  void onMonthChange(value) {
    setState(() {
      _selectedMonth = value;
    });
  }

  void onDayChange(value) {
    setState(() {
      _day = value;
    });
  }

  Widget getForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            onChanged: (String value) {
              onDayChange(value);
            },
          ),
          new DropdownButton<String>(
              value: _selectedMonth,
              items: _months.map((String value) {
                return new DropdownMenuItem(
                    value: value, child: new Text("${value}"));
              }).toList(),
              onChanged: (String value) {
                onMonthChange(value);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text("Request"),
              onPressed: () =>
                  {homeController.searchByThisDay("$_day de $_selectedMonth")},
            ),
          )
        ],
      ),
    );
  }
}
