import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class DataUtilities{

  /*
  * this method to convert the date time to readable case
  * */
  String parsHumanDate(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDifference = DateTime.now().subtract(timeAgo);
    return timeago.format(theDifference, locale: 'en_short');
  }
  /*
  * this method for loading progress indicator
  * */
  Widget loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.blueGrey.shade300,),
      ),
    );
  }

  /*
  * this method for no data
  * */
  Widget noData() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('No Data Available!!'),
    );
  }

  /*
  * This method returned when an error happen when getting data
  * */
  Widget error(Object error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(error.toString()),
    );
  }

  /*
  * This method returned when failed to connect to the server
  * */
  Widget connectionError() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('Connection Error'),
    );
  }
}