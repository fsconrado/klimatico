import 'package:flutter/material.dart';
import 'package:klimatico/transacoes/pega_clima.dart';
import 'package:klimatico/util/util.dart' as util;

import 'ActivityMudarCidade.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _cidadeInserida;

  Future _abrirNovaTela(BuildContext context) async {
    Map resultado = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (context) {
      return MudarCidade();
    }));
    if(resultado !=null && resultado.containsKey('cidade')){
      _cidadeInserida = resultado['cidade'];
      debugPrint(_cidadeInserida);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klimático"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[IconButton(icon: Icon(Icons.menu), onPressed: () {
          _abrirNovaTela(context);
        })],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/umbrella.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Text("Olá ${_cidadeInserida ?? util.minhaCidade}!", style: TextStyle(color: Colors.white),)],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("assets/images/light-rain.png"),
          ),
          atualizarTempWidget(_cidadeInserida)
        ],
      ),
    );
  }

  Widget atualizarTempWidget(String cidade) {
    return FutureBuilder(
      future: pegaClima(util.appId, cidade ?? util.minhaCidade),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData){
          Map conteudo = snapshot.data;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(conteudo["main"]["temp"].toString()+"C"),
                  subtitle: ListTile(
                    title: Text("Humidade"),
                  ),
                )
              ],
            ),
          );
        } else{
          return Container(
            child: Text("Falhou :(")
          );
        }
      },
    );
  }
}

