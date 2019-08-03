import 'package:flutter/material.dart';

//Uma outra Tela
class MudarCidade extends StatelessWidget {

  var _cidadeCampoControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Mudar Cidade"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/images/white-snow.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                      hintText: 'Cidade'
                  ),
                  controller: _cidadeCampoControl,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(
                  onPressed: (){
                    Navigator.pop(context, {'cidade':_cidadeCampoControl.text});
                  },
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: Text("Mostrar o tempo"),),
              )
            ],
          )
        ],
      ),
    );
  }
}
