import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:calculator_app/utils/theme_changer.dart';
import 'package:calculator_app/utils/theme_provider.dart';
import 'package:calculator_app/utils/colors.dart';

// Instances for Theme Provider
ThemeProvider _themeProvider = ThemeProvider();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String firstNum = '';
  late String secondNum = '';
  late String operation = '';
  late String historyFirstNum = '';
  late String historySecondNum = '';
  late String historyOperation = '';
  late String textToDisplay = '';
  late bool equalPress = false;

  @override
  void dispose() {
    _themeProvider.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeProvider.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      changeTheme(_themeProvider.isLightMode);
      setState(() {});
    }
  }

  void onButtonClick(String btntxt) {
    void equalButtonPressed() {
      if (operation != '') {
        secondNum =
            textToDisplay.substring(textToDisplay.indexOf(operation) + 1);
        if (secondNum == '') {
          secondNum = (operation == '/' || operation == 'x') ? '1' : '0';
        }

        // Converting string no. to int no.
        final _firstNum = num.parse(firstNum);
        final _secondNum = num.parse(secondNum);

        // Operations
        if (operation == '+') {
          textToDisplay = (_firstNum + _secondNum).toString();
        }
        if (operation == '-') {
          textToDisplay = (_firstNum - _secondNum).toString();
        }
        if (operation == '/') {
          textToDisplay = (_firstNum / _secondNum).toString();
        }
        if (operation == 'x') {
          textToDisplay = (_firstNum * _secondNum).toString();
        }
        // Adding to history
        historyFirstNum = firstNum;
        historySecondNum = secondNum;
        historyOperation = operation;
      } else {
        historyFirstNum = '';
        historySecondNum = '';
        historyOperation = '';
      }

      equalPress = true;
    }

    // Clear All Pressed
    if (btntxt == 'AC') {
      firstNum = '1';
      secondNum = '1';
      operation = '';
      historyFirstNum = '';
      historySecondNum = '';
      historyOperation = '';
      textToDisplay = '';
      btntxt = '';
    }
    // Clear Result Pressed
    else if (btntxt == 'C') {
      firstNum = '1';
      secondNum = '1';
      operation = '';
      textToDisplay = '';
      btntxt = '';
    }
    // Delete last number Pressed
    else if (btntxt == '<') {
      if (textToDisplay != '') {
        // Check if the operation is to remove the operator
        String lastString = textToDisplay.substring(textToDisplay.length - 1);
        if (lastString == '/' ||
            lastString == 'x' ||
            lastString == '-' ||
            lastString == '+') {
          operation = '';
          firstNum = '';
        }

        textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
        btntxt = '';
      }
    }
    // Dot clicked
    else if (btntxt == '.') {
    }
    // Equal Button Pressed
    else if (btntxt == '=') {
      equalButtonPressed();

      firstNum = '1';
      secondNum = '1';
      operation = '';
      btntxt = '';
    }
    // Operation Button Pressed
    else if (btntxt == '/' || btntxt == 'x' || btntxt == '-' || btntxt == '+') {
      // If operator is entered before numbers
      if (textToDisplay == '') {
        textToDisplay = (btntxt == '/' || btntxt == 'x') ? '1' : '0';
        operation = btntxt;
        firstNum = textToDisplay;
      }
      // If only one operator is used
      else if (!(textToDisplay.contains('+') ||
          textToDisplay.contains('-') ||
          textToDisplay.contains('x') ||
          textToDisplay.contains('/'))) {
        operation = btntxt;
        firstNum = textToDisplay;
      }

      // If more than one operator is used
      // **Here we execute using first operand then second**
      else {
        // When multiple operators are clicked alternately
        int length = textToDisplay.length;
        if (textToDisplay.contains('+', length - 1) ||
            textToDisplay.contains('-', length - 1) ||
            textToDisplay.contains('x', length - 1) ||
            textToDisplay.contains('/', length - 1)) {
          operation = btntxt;
          textToDisplay = textToDisplay.substring(0, length - 1);
        } else {
          // When multiple operators are clicked after entering second number
          equalButtonPressed();
          firstNum = textToDisplay;
          secondNum = '1';
          operation = btntxt;
        }
      }
      equalPress = false;
    }
    // Start new calculation if number is pressed instead of operator after performing certain calculations previously
    else if (equalPress) {
      historyFirstNum = '';
      historySecondNum = '';
      historyOperation = '';
      textToDisplay = '';
      equalPress = false;
    }

    setState(() {
      textToDisplay += btntxt;
    });
  }

  screenMode() {
    return Center(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: contColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _themeProvider.toggleTheme(false),
              splashRadius: 1,
              icon: const Icon(Icons.light_mode_outlined),
              color: const Color(0xFF52555c),
            ),
            IconButton(
              onPressed: () => _themeProvider.toggleTheme(true),
              splashRadius: 1,
              icon: const Icon(Icons.dark_mode_outlined),
              color: const Color(0xFFc2c4c6),
            ),
          ],
        ),
      ),
    );
  }

  resultDisplay() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
              text: TextSpan(
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: numColor2),
                  children: <TextSpan>[
                TextSpan(text: historyFirstNum),
                TextSpan(
                    text: ' $historyOperation ',
                    style: TextStyle(color: operColor2)),
                TextSpan(text: historySecondNum),
              ])),
          const SizedBox(height: 5),
          Text(
            textToDisplay,
            style: GoogleFonts.lato(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: numColor1,
            ),
          ),
        ],
      ),
    );
  }

  Widget calcButton(String btntxt, Color txtcolor) {
    return Container(
      decoration: BoxDecoration(
        color: contColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: buttonColor,
            padding: const EdgeInsets.all(10),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        child: Text(btntxt,
            style: TextStyle(
              fontSize: 25,
              color: txtcolor,
            )),
        onPressed: () => onButtonClick(btntxt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Buttons
              screenMode(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Result Display
                  resultDisplay(),

                  // Operational Buttons
                  Container(
                    height: 0.6 * (MediaQuery.of(context).size.height),
                    decoration: BoxDecoration(
                      color: contColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            calcButton('AC', operColor1),
                            calcButton('C', operColor1),
                            calcButton('<', operColor1),
                            calcButton('/', operColor2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            calcButton('7', numColor1),
                            calcButton('8', numColor1),
                            calcButton('9', numColor1),
                            calcButton('x', operColor2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            calcButton('4', numColor1),
                            calcButton('5', numColor1),
                            calcButton('6', numColor1),
                            calcButton('-', operColor2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            calcButton('1', numColor1),
                            calcButton('2', numColor1),
                            calcButton('3', numColor1),
                            calcButton('+', operColor2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            calcButton('0', numColor1),
                            calcButton('00', numColor1),
                            calcButton('.', numColor1),
                            calcButton('=', operColor2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
