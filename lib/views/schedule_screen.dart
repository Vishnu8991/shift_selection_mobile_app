import 'package:flutter/material.dart';



class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selected Working time"),),
      body: Scaffold(
        body: Container(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Text("data"),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}