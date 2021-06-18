import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SearchDelegate.dart';
class CountryStatusPage extends StatefulWidget {

  @override
  _CountryStatusPageState createState() => _CountryStatusPageState();
}

class _CountryStatusPageState extends State<CountryStatusPage> {
  bool isLoading = false;
  List countryData = [];
  Future fetchCountryData() async{
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
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: Search(countryData: countryData));
              },
            )
          ],
          title: Text('Country Status'),
          centerTitle: false,
        ),
        body: isLoading ? Center(
          child: CircularProgressIndicator(),
        ) : RefreshIndicator(
          onRefresh: fetchCountryData,
          child: ListView.builder(itemBuilder: (context,index){
            return Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 20.0,
                      offset: Offset(0,10),
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              countryData[index]['country'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                          Image.network(countryData[index]['countryInfo']['flag'],
                          height: 60,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: Column(
                          children: [
                            Text('Cases Today: ' + countryData[index]['todayCases'].toString(),style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.red,
                            ),),
                            Text('Recovered Today: ' + countryData[index]['todayRecovered'].toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),),
                            Text('active cases: ' + countryData[index]['active'].toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),),
                            Text('deaths: ' + countryData[index]['deaths'].toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),)
                          ],

                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: countryData.length,
          ),
        ),
      ),
    );
  }
}
