import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
 class WorldTime {
   late String location; // location name for ui
   late String time;
   late String flag;
   late String url;
   late bool isDayTime;


   WorldTime({required this.location, required this.flag, required this.url}) {
     Future<void> getTime() async {
       try {
         Response response = await get(
             Uri.http('worldTimeapi.org', '/api/timezone/$url'));
         Map data = jsonDecode(response.body);
         //print(data);
         String datetime = data['datetime'];
         String offset = data['utc_offset'].substring(1, 3);
         //print(datetime);
         // print(offset);
         DateTime now = DateTime.parse(datetime);
         now = now.add(Duration(hours: int.parse(offset)));
         isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
         time = DateFormat.jm().format(now);
       }
       catch (e) {
         if (kDebugMode) {
           print('caught error: $e');
         }
         time = ' could not find time';
       }
     }
   }

  
 }
