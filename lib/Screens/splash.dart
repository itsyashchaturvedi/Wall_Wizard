import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children:[ Padding(
            padding: const EdgeInsets.only(top: 215),
            child: Center(
              child: Image.asset("assets/all.gif",fit: BoxFit.fitHeight,),
            ),
          ),
            Expanded(child: SizedBox()),
            Text("@This Application is developed by Yash Chaturvedi",style: TextStyle(fontSize: 13,color: Colors.black38)),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
