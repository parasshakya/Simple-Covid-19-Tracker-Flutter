import 'package:covid_19_tracker_app/dataSource.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'FAQs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ExpansionTile(
                title: Text(DataSource.questionAnswers[index]['question'],style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(DataSource.questionAnswers[index]['answer']),
                  ),
                ],
            );
          },
          itemCount: DataSource.questionAnswers.length,
        ));
  }
}
