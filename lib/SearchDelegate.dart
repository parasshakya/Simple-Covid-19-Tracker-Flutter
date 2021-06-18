import 'package:flutter/material.dart';

class Search extends SearchDelegate{

   List countryData;
  Search({required this. countryData});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List suggestionList = query.isEmpty ?
    countryData : countryData.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index){
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
                          suggestionList[index]['country'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ),
                      Image.network(suggestionList[index]['countryInfo']['flag'],
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
                        Text('Cases Today: ' + suggestionList[index]['todayCases'].toString(),style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.red,
                        ),),
                        Text('Recovered Today: ' + suggestionList[index]['todayRecovered'].toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),),
                        Text('active cases: ' + suggestionList[index]['active'].toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),),
                        Text('deaths: ' + suggestionList[index]['deaths'].toString(),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionList = query.isEmpty ?
    countryData : countryData.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index){
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
                          suggestionList[index]['country'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ),
                      Image.network(suggestionList[index]['countryInfo']['flag'],
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
                        Text('Cases Today: ' + suggestionList[index]['todayCases'].toString(),style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.red,
                        ),),
                        Text('Recovered Today: ' + suggestionList[index]['todayRecovered'].toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),),
                        Text('active cases: ' + suggestionList[index]['active'].toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),),
                        Text('deaths: ' + suggestionList[index]['deaths'].toString(),
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
    );
  }

}