import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {

  String equation = '0';
  String result = '0';
  String expression = '';

  //function for button working

  buttonPresed(btnText){
    setState(() {
      if (btnText == 'AC') {

        equation = '0';
        result = '0';

      } else if (btnText == '+/-') {

        equation = equation.substring(0, equation.length -1);

        if (equation == '') {
          equation = '0';
        }

      } else if (btnText == '=') {

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');


        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        }
        catch (e){
          'Error';
        }

      }else{
        if (equation == '0') {
          equation = btnText;
        }else
          equation = equation + btnText;
      }
    });
  }


  Widget buildButtons(
      double btnsWith, Color btnsColor, String btnsText, Color textColor) {
    return InkWell(
      onTap: () {
        setState(() {
          buttonPresed(btnsText);
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnsWith,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: btnsColor,
        ),
        child: Text(
          '$btnsText',

          style: TextStyle(
            color: textColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Text(
                equation,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Text(
                result,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButtons(80, Colors.grey, 'AC', Colors.black),
                    buildButtons(80, Colors.grey, '+/-', Colors.black),
                    buildButtons(80, Colors.grey, '%', Colors.black),
                    buildButtons(80, Colors.amber.shade700, '/', Colors.white),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButtons(80, Colors.white10, '7', Colors.grey),
                    buildButtons(80, Colors.white10, '8', Colors.grey),
                    buildButtons(80, Colors.white10, '9', Colors.grey),
                    buildButtons(80, Colors.amber.shade700, 'x', Colors.white),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButtons(80, Colors.white10, '4', Colors.grey),
                    buildButtons(80, Colors.white10, '5', Colors.grey),
                    buildButtons(80, Colors.white10, '6', Colors.grey),
                    buildButtons(80, Colors.amber.shade700, '-', Colors.white),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButtons(80, Colors.white10, '1', Colors.grey),
                    buildButtons(80, Colors.white10, '2', Colors.grey),
                    buildButtons(80, Colors.white10, '3', Colors.grey),
                    buildButtons(80, Colors.amber.shade700, '+', Colors.white),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    buildButtons(170, Colors.white10, '0', Colors.grey),
                    buildButtons(80, Colors.white10, '.', Colors.grey),
                    buildButtons(80, Colors.amber.shade700, '=', Colors.white),
                  ],
                ),
                           ],
            ),
          )
        ],
      ),
    );
  }
}
