import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {

  final Map worldData;
  WorldWidePanel({required this.worldData});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 330,
      child: GridView(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:2, mainAxisExtent:150),
        children: [
          StatusPanel(
            title: "CONFIRMED",
            panelColor: Colors.red.shade200,
            textColor: Colors.red,
            count: worldData['cases'].toString()
          ),
          StatusPanel(
              title: "ACTIVE",
              panelColor: Colors.blue.shade200,
              textColor: Colors.blue,
              count: worldData['active'].toString()
          ),
          StatusPanel(
              title: "RECOVERED",
              panelColor: Colors.green.shade200,
              textColor: Colors.green,
              count: worldData['recovered'].toString()
          ),
          StatusPanel(
              title: "DEATHS",
              panelColor: Colors.black26,
              textColor: Colors.black,
              count: worldData['deaths'].toString()
          ),

        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

   StatusPanel({required this.panelColor, required this.textColor,required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      color: panelColor,
      width: width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),),
          Text(count, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),),
        ],
      ),
    );
  }
}

