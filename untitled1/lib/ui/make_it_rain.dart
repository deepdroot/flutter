import 'package:flutter/material.dart';



class MakeItRain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MakeItRainState();
  }

}

class MakeItRainState extends State<MakeItRain> {


  int _moneyCounter = 0;

  _rainMoney(){
    setState(() {
      _moneyCounter += 121;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make it Rain"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        child: Column(
          children: <Widget>[ Center(
            child: Text("Get Rich!",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 29.9,
                  fontWeight: FontWeight.w400
              ),),
          ),
            Expanded(
              child: Center(
                child: Text("\$ $_moneyCounter",
                style: TextStyle(
                  color: _moneyCounter>10000?Colors.greenAccent: _moneyCounter>4000?Colors.yellow:Colors.red,
                  fontSize: 46.9,
                    fontWeight: FontWeight.w800
                ),),
              ),
            ),
            Expanded(
              child: Center(
                child: FlatButton(
                  color: Colors.green,
                    textColor: Colors.white70,
                    child: Text(
                  "Make it Rain!",
                  style: TextStyle(
                    fontSize: 19.9
                  ),
                ),onPressed: ()=>_rainMoney()),

              ),
            )

          ],
        ),
      ),
          );
  }
}


