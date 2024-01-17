import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var pics = [];

  void get() async{
    var a = [];
    for(int i = 0; i < 10; i++) {
      var response = await dio.get(
        'https://api.nasa.gov/planetary/apod',
        queryParameters: {
          'api_key': "NDGT2IkBHMoUF97eunoGIyXTTZQbnuoliDgj2vQ5",
          'count': 1

        },
      );
      if(response.data[0]['hdurl']==null){response = await dio.get(
        'https://api.nasa.gov/planetary/apod',
        queryParameters: {
          'api_key': "NDGT2IkBHMoUF97eunoGIyXTTZQbnuoliDgj2vQ5",
          'count': 1

        },
      );}
      a.add(response.data[0]['hdurl']);

    }
    setState(() {
      pics.addAll(a);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          ListView.builder(itemCount: pics.length+1,itemBuilder: (context,index){
            if(index==0){
            return Center(child: OutlinedButton(onPressed: get, child: Text("More pictures!")));}
            else{return Image(image: NetworkImage(pics[index-1]));}
          })

    );
  }
}
