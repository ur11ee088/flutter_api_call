import 'package:flutter/material.dart';

import 'model/student_data.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HttpScreen(),
    );
  }
}

class HttpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: FutureBuilder<StudentData>(
         future: getStudent(),
         builder: (context, snapshot){
           if(snapshot.hasData){
             return Text(""
                 "name: ${snapshot.data.title}\n"
                 "Id: ${snapshot.data.userId}");

           }else if(snapshot.hasError){
             debugPrint("has error");
             return Text("${snapshot.error}");

           }
           return CircularProgressIndicator();
         },
       )
     ),

   );
  }

}

Future<StudentData> getStudent() async{
  final url ="https://jsonplaceholder.typicode.com/todos/1";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String,dynamic> string = jsonDecode(response.body);
    return StudentData.fromJson(string);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }

}
