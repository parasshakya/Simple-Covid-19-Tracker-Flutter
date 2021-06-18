import 'dart:convert';
import 'package:covid_19_tracker_app/CountryStatusPage.dart';
import 'package:covid_19_tracker_app/panels/InfoPanel.dart';
import 'package:covid_19_tracker_app/panels/MostAffectedPanel.dart';
import 'package:covid_19_tracker_app/panels/WorldWidePanel.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dataSource.dart';
import 'package:covid_19_tracker_app/AppThemes.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = false;
  bool isLoadingWorldData = false;

  Map worldData = Map();
  fetchWorldWideData() async{
    setState(() {
      isLoadingWorldData = true;
    });
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/all'
    ));
    setState(() {
      worldData = json.decode(response.body);
    });
    setState(() {
      isLoadingWorldData = false;
    });
  }

  Future fetchData() async{
    fetchWorldWideData();
    fetchCountryData();
  }
  List countryData = [];
  fetchCountryData() async{
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries'));
    setState(() {
      countryData = json.decode(response.body);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('COVID-19 TRACKER'),
          centerTitle: false,
        ),
        body: RefreshIndicator(
          onRefresh: fetchData ,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  height: 100,
                  color: Colors.orange[100],
                  child: Text(DataSource.quote, style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ), ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0,
                          left: 20.0, right: 10.0
                      ),
                      child: Text('WorldWide', style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => CountryStatusPage(),
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'Country Status',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                isLoadingWorldData ? Container(
                    height: 200,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: CircularProgressIndicator()): Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, ),
                  child:  WorldWidePanel(worldData: worldData,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(' Top 5 Most Affected Countries', style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                isLoading ? Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: CircularProgressIndicator()) : MostAffectedPanel(countryData: countryData,),

                InfoPanel(),
                SizedBox(height: 20.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.health_and_safety
                      ),
                      SizedBox(width: 3.0,),
                      Text('PLEASE STAY SAFE',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(width: 3.0,),
                      Icon(
                        Icons.health_and_safety
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
