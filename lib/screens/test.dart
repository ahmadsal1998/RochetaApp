// ignore_for_file: avoid_print, unnecessary_new, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class MyApp5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GridView'),
        ),
        body: Center(
          child: Container(
            // height: 200,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: [
                Card(
                  child: new InkWell(
                  onTap: () {
                      print("tapped");
                      },
                    child: Container(
                      child: Icon(Icons.child_care,size: 50),
                    width: 100.0,
                    height: 100.0,
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                  onTap: () {
                      print("tapped");
                      },
                    child: Container(
                      child: Icon(Icons.heart_broken),
                    width: 100.0,
                    height: 100.0,
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                  onTap: () {
                      print("tapped");
                      },
                    child: Container(
                      child: Icon(Icons.heart_broken),
                    width: 100.0,
                    height: 100.0,
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                  onTap: () {
                      print("tapped");
                      },
                    child: Container(
                      child: Icon(Icons.heart_broken),
                    width: 100.0,
                    height: 100.0,
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                  onTap: () {
                      print("tapped");
                      },
                    child: Container(
                      child: Icon(Icons.heart_broken),
                    width: 100.0,
                    height: 100.0,
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
               Card(
                  child: new InkWell(
                  onTap: () {
                      print("tapped");
                      },
                    child: Container(
                      child: Icon(Icons.heart_broken),
                    width: 100.0,
                    height: 100.0,
                    ),
                  ),
               
                  color: Colors.blue,
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}