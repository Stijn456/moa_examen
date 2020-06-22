import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class home_pagina extends StatefulWidget {
  @override
  _home_paginaState createState() => _home_paginaState();
}

class _home_paginaState extends State<home_pagina> {

    int value = 100;
    String land = "Nederland";
    String image = "assets/images/flag (2).png";


    Widget custom_box(String tekstBox) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50.0,
          child: Material(
            color: Colors.blue[800],
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      image: AssetImage(
                          '$image'),
                    ),
                  ),
                ),
                Container(
                  child: Text(tekstBox, style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Future<List> countries;

    Future<List> getCountries() async {
      var url = 'https://api.covid19api.com/summary';
      var response = await http.get(url);

      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["Countries"];

      return(data);
    }

    @override
    void initState() {
      countries = getCountries();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text('Home', style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w600
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('assets/images/Corona.png'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Gegevens $land', style: TextStyle(
                fontSize: 25, color: Colors.white
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List>(
              future: countries,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasData) {
                  print(snapshot.data);
                  return Expanded(
                    child: SizedBox(
                      height: 80,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          var confirmed = snapshot.data[value]["TotalConfirmed"].toString();
                          var deaths = snapshot.data[value]["TotalDeaths"].toString();
                          var recovered = snapshot.data[value]["TotalRecovered"].toString();

                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: DropdownButton<int>(
                                  items: [
                                    DropdownMenuItem<int>(
                                      value: 1,
                                      child: Center(
                                        child: Text("Nederland"),
                                      ),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 2,
                                      child: Center(
                                        child: Text("Amerika"),
                                      ),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 3,
                                      child: Center(
                                        child: Text("Duitsland"),
                                      ),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 4,
                                      child: Center(
                                        child: Text("Rusland"),
                                      ),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 5,
                                      child: Center(
                                        child: Text("Afghanistan"),
                                      ),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 6,
                                      child: Center(
                                        child: Text("China"),
                                      ),
                                    ),
                                  ],

                                  //Switch statement voor het land.
                                  onChanged: (_value) => {
                                    setState((){
                                      value = _value;
                                      switch(value){
                                        case 1 : land = "Nederland";
                                        image = "assets/images/flag (2).png";
                                        break;
                                        case 2 : land = "Amerika";
                                        image = "assets/images/flag (3).png";
                                        break;
                                        case 3 : land = "Duitsland";
                                        image = "assets/images/flag (1).png";
                                        break;
                                        case 4 : land = "Rusland";
                                        image = "assets/images/flag (4).png";
                                        break;
                                        case 5 : land = "Afghanistan";
                                        image = "assets/images/flag (5).png";
                                        break;
                                        case 6 : land = "China";
                                        image = "assets/images/flag (6).png";
                                        break;

                                        default : "";
                                        break;
                                      }
                                    }),
                                  },

                                  hint: Text("Selecteer een land", style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white, fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                              ),
                              custom_box('  Aantal Doden: ${deaths}'),
                              custom_box('  Aantal Zieken: ${confirmed}'),
                              custom_box('  Aantal genezen: ${recovered}')
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
                return Text('Failed');
              },
            ),
          ],
        ),
      );
    }
  }