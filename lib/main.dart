import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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

  // String changed;
  // String submitted;

  bool interrupteur = false;
  double sliderDouble = 0.0;

  int itemSelectionne;

  DateTime date;

  List<Widget> radios() {
    List<Widget> l = [];
    for (int x = 0 ; x < 4 ; x++) {
      Row row = Row(
        children:<Widget>[
          Text('Choix ${x + 1}'),
          Radio(
            value: x,
            groupValue: itemSelectionne,
            onChanged: (int i) {
              setState((){
                itemSelectionne = i;
              });
            })
        ]
      );
      l.add(row);
    }
    return l;
  }

  Map check = {
    'Carottes': false,
    'Bananes': false,
    'Yaourt': false,
    'Pain': false
  };

  List<Widget> checkList() {
    List<Widget> l = [];
    check.forEach((key, value) {
      Row row = Row(
        children: [
          Text(key),
          Checkbox(
            value: value,
            onChanged: (bool b) {
              setState(() {
                check[key] = b;
              });
            }
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        );
        l.add(row);
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     FocusScope.of(context).requestFocus(FocusNode());
    //   },
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text(widget.title),
    //     ),
    //     body: Center(
    //       child: Column(
    //         children: <Widget>[
    //           TextField(
    //             keyboardType: TextInputType.number,
    //             onChanged: (String string) {
    //               setState(() => changed = string);
    //             },
    //             onSubmitted: (String string) {

    //             },
    //             decoration: InputDecoration(
    //               labelText: 'Entrez votre nom.'
    //             )
    //           ),
    //           Text(changed ?? ''),
    //           Text(submitted ?? '')
    //         ],
    //         mainAxisAlignment: MainAxisAlignment.center
    //       )
          
    //     ),
    //   )
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: montrerDate,
                child: Text(
                  date == null ? 'Appuyer' : date.toString()
                ))
              // Text('Aimez-vous les haricots ?'),
              // Slider(
              //   value: sliderDouble,
              //   min:0,
              //   max: 10,
              //   onChanged: (double d) {
              //     setState(() {
              //       sliderDouble = d;
              //     });
              //   }
              // )
              // Switch(
              //   value: interrupteur,
              //   inactiveTrackColor: Colors.orange,
              //   activeTrackColor: Colors.blue,
              //   onChanged: (bool b) {
              //     setState(() {
              //       interrupteur = b;
              //     });
              //   }
              // )
            ]
          )
        )
    );
  }

  Future<Null> montrerDate() async {
    DateTime choix = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(1983),
      lastDate: DateTime(2045)
    );
    if (choix != null) {
      setState(() {
        date = choix;
      });
    }
  }
}
