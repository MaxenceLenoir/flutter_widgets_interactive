import 'package:flutter/material.dart';
import './customText.dart';

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

  double poids;
  // String submitted;

  bool genre = false;
  double taille = 150;
  int age;

  int radioSelectionne;

  DateTime date;

  Map activiteSport = {
    1: "faible",
    2: "modere",
    3: "forte"
  };

  int calorieBase;
  int calorieWithActivity;

  List<Widget> radios() {
    List<Widget> l = [];
    activiteSport.forEach((key, value) { 
      Column column = Column(
        children:<Widget>[
          CustomText(value, color: setColor(), factor: 1.3),
          Radio(
            activeColor: setColor(),
            value: key,
            groupValue: radioSelectionne,
            onChanged: (Object i) {
              setState((){
                radioSelectionne = i;
              });
            }
          )
        ]
      );
      l.add(column);
    });
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
    double height = 500;
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
    return 
      GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: setColor(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: CustomText(
                          'Remplissez tous les champs pour remplir votre besoin journalier en calories.',
                          factor: 1.2,
                  ),
                ),
                Container(
                  height: height,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomText(
                                  'Homme',
                                  color: Colors.blue,
                                  factor: 1.3,
                                ),
                                Switch(
                                  value: genre,
                                  inactiveTrackColor: Colors.blue,
                                  thumbColor: MaterialStateProperty.all(Colors.grey[100]),
                                  activeTrackColor: Colors.pink,
                                  onChanged: (bool b) {
                                    setState(() {
                                      genre = b;
                                    });
                                  }
                                ),
                                CustomText(
                                  'Femme',
                                  color: Colors.pink,
                                  factor: 1.3,
                                ),
                              ]
                            )
                          ),
                          TextButton(
                            child: CustomText(date == null ? 'Appuyer' : calculAge(date), factor: 1.3, color: Colors.white),
                            onPressed: () {
                              montrerDate();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return setColor().withOpacity(0.5);
                                  return setColor(); // Use the component's default.
                                },
                              ),
                            ),
                          ),
                          CustomText(
                            'Votre taille est de ${taille.floor()} cm',
                          ),
                          Slider(
                            value: taille,
                            activeColor: setColor(),
                            min:100,
                            max: 220,
                            onChanged: (double d) {
                              setState(() {
                                taille = d;
                              });
                            }
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (String string) {
                                setState(() {
                                  poids = double.tryParse(string);
                                });
                              },
                              decoration: InputDecoration(
                                labelText: "Entrez votre poids en kilos."
                              ),
                            ),
                          ),
                          CustomText(
                            'Quelle est votre activité sportive',
                            factor: 1.3
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: radios()
                          ),
                        ]
                      )
                  )
                ),
                ElevatedButton(
                  onPressed: () {
                    calcNumberCalories ();
                  },
                  child: Text(
                    'Calculer'
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return setColor().withOpacity(0.5);
                        return setColor(); // Use the component's default.
                      },
                    ),
                  ),
                )
              ]
            ),
          )
        )
      ) 
    );
  }

  Future<Null> montrerDate() async {
    DateTime choix = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );
    if (choix != null) {
      setState(() {
        date = choix;
      });
    }
  }

  String calculAge(date) {
    setState(() {
      age = (DateTime.now().difference(date).inDays / 365).floorToDouble().toInt();
    });
    return "Votre age est de : $age ans.";
  }

  void calcNumberCalories() {
    if (date != null && poids != null && radioSelectionne != null) {
      if (genre) {
        calorieBase = (66.4730 + (13.7516 * poids) + (5.0033 * taille) - (6.7550 * age)).toInt();
      } else {
        calorieBase = (655.0955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)).toInt();
      }
      switch(radioSelectionne) {
        case 1:
          calorieWithActivity = (calorieBase * 1.2).toInt();
          break;
        case 2:
          calorieWithActivity = (calorieBase * 1.5).toInt();
          break;
        case 3:
          calorieWithActivity = (calorieBase * 1.8).toInt();
          break;
        default:
          calorieWithActivity = calorieBase;
          break;
      }
      setState(() {
        dialog();
      });
    } else {
      alert();
    }
  }

  Future<Null> dialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return SimpleDialog(
          title: CustomText('Votre besoin en calorie', color: setColor()),
          contentPadding: EdgeInsets.all(15),
          children: <Widget>[
            CustomText('Votre besoin de base est de: $calorieBase'),
            CustomText('Votre besoin avec activité sportive est de: $calorieWithActivity'),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(buildContext);
              },
              child: CustomText("Ok", color: Colors.white)
            ),
          ],
        );
      }
    );
  }

  Future<Null> alert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: CustomText('Erreur', color: Colors.red, factor: 1.5),
          content: CustomText('Tous les champs ne sont pas remplis'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.pop(buildContext);
              },
              child: CustomText("Ok")
            ),
          ],
        );
      });
  }

  Color setColor() {
    if (genre) {
      return Colors.pink;
    } else {
      return Colors.blue;
    }
  }
}
