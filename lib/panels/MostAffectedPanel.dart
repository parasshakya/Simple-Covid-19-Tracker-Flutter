import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {

   final List countryData;

  MostAffectedPanel({required this.countryData});



  @override
  Widget build(BuildContext context) {

    countryData.sort((a,b) => b['deaths'].compareTo(a['deaths']));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.0),
      child: ListView.builder(

        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,

        itemBuilder: (context,index){

        return Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
           child: Row(
             children: [
               Image.network(
                 countryData[index]['countryInfo']['flag'],
                 height: 30,
                 width: 40,
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Text(countryData[index]['country'],
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                 ),),
               ),
               Text('Deaths:' + countryData[index]['deaths'].toString(),
                 style: TextStyle(
                   color: Colors.red,
                   fontWeight: FontWeight.bold,
                 ),
               )
             ],
           ),
        );
      },
      itemCount: 5,
      ),
    );
  }
}
