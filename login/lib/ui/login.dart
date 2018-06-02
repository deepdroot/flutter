import 'package:flutter/material.dart';







class Login extends StatefulWidget{

  @override
  State createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {

  final  _userController = TextEditingController();
  final  _passwordController = TextEditingController();



  _clean(){
    setState(() {
      _passwordController.clear();
      _userController.clear();
      _name="";
    });
  }

  var _name = "";
_showWelcome(){
    setState(() {
      _name = _userController.text;
    });
}

String teste(){
  _showWelcome();
  return _name;

}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        backgroundColor: Colors.blueGrey,
        body: Container(
          alignment: Alignment.topCenter,
          child: new ListView(

            children: <Widget>[
              Column(
                children: <Widget>[
                  //image profile
                  new Image.asset('images/face.png',
                    width: 90.0,
                    height: 90.0,
                    color: Colors.blue,),
                  //form
                  Container(

                    width: 380.0,
                    //height: 150.0,
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                              labelText: "User name",
                              icon: Icon(Icons.person)
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,

                          decoration: InputDecoration(

                              labelText: "Password",
                              icon: Icon(Icons.lock)
                          ),
                          obscureText: true,

                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: new EdgeInsets.fromLTRB(0.0, 8.0, 4.0, 0.0),
                                child: new RaisedButton(onPressed: _showWelcome, child: Text("Login",
                                  style: TextStyle(
                                      fontSize: 17.0
                                  ),),
                                  color: Colors.blue,

                                  textColor: Colors.white,),
                              ),
                            ),

                            Expanded(
                              child: new Padding(padding: EdgeInsets.fromLTRB(4.0,8.0,0.0,0.0),
                                child: new RaisedButton(onPressed: _clean, child: Text("Clear",
                                  style: TextStyle(
                                      fontSize: 17.0
                                  ),),
                                  color: Colors.blue,
                                  textColor: Colors.white,),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0),
                    child: Text("Welcome ${teste()}",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500
                      ),),)

                ],
              )
            ],
          )

          ,
        ),
      )
    );
  }
}