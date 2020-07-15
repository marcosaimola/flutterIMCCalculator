import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _infotext = "Informe seus dados";

  void resetText() {

    weightController.text = "";
    heightController.text = "";

    setState(() {
      _infotext = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.6)
        _infotext = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      else if (imc >= 18.6 && imc < 24.9)
        _infotext = "Peso ideal (${imc.toStringAsPrecision(2)})";
      else if (imc > -24.9 && imc < 29.9)
        _infotext = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      else if (imc >= 29.9 && imc < 34.9)
        _infotext = "Obesidade grau 1 (${imc.toStringAsPrecision(2)})";
      else if (imc >= 34.9 && imc < 39.9)
        _infotext = "Obesidade grau 2 (${imc.toStringAsPrecision(2)})";
      else
        _infotext = "Obesidade grau 3 (${imc.toStringAsPrecision(2)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetText,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 120,
                color: Colors.lightGreen,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: Colors.lightGreen)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty) {
                    return "Insire seu peso.";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.lightGreen)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty)
                    return "Insire sua altura.";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate())
                          calculate();
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.lightGreen),
                ),
              ),
              Text(
                _infotext,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black12, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
