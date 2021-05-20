import 'dart:async';
import 'dart:math';

import 'package:example_state_button/src/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProgressButtonHomePage(title: 'Progress Button'),
    );
  }
}

class ProgressButtonHomePage extends StatefulWidget {
  ProgressButtonHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProgressButtonHomePageState createState() => _ProgressButtonHomePageState();
}

class _ProgressButtonHomePageState extends State<ProgressButtonHomePage> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // buildCustomButton(),
            // Container(
            //   height: 32,
            // ),
            buildTextWithIcon(),
            // Container(
            //   height: 32,
            // ),
            // buildTextWithIconWithMinState(),
          ],
        ),
      ),
    );
  }

  Widget buildCustomButton() {
    return ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text(
          "Boton",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.loading: Text(
          "Cargando",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.fail: Text(
          "Error",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.success: Text(
          "Exitoso",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      },
      stateColors: {
        ButtonState.idle: Colors.grey.shade400,
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      onPressed: onPressedCustomButton,
      state: stateOnlyText,
      padding: EdgeInsets.all(8.0),
    );
  }

  // Widget buildTextWithIcon() {
  //   return ProgressButton.icon(iconedButtons: {
  //     ButtonState.idle: IconedButton(
  //         text: "Enviar",
  //         icon: Icon(Icons.send, color: Colors.white),
  //         color: Colors.deepPurple.shade500),
  //     ButtonState.loading:
  //         IconedButton(text: "Cargando...", color: Colors.deepPurple.shade700),
  //     ButtonState.fail: IconedButton(
  //         text: "Error",
  //         icon: Icon(Icons.cancel, color: Colors.white),
  //         color: Colors.red.shade300),
  //     ButtonState.success: IconedButton(
  //         text: "Exitoso",
  //         icon: Icon(
  //           Icons.check_circle,
  //           color: Colors.white,
  //         ),
  //         color: Colors.green.shade400)
  //   }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  // }
  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Enviar",
          icon: Icon(Icons.send, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Cargando...", color: Colors.deepPurple.shade700),
      ButtonState.fail: IconedButton(
          text: "Error",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "Exitoso",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Guardar",
            icon: Icon(Icons.send, color: Colors.white),
            color: Colors.deepPurple.shade500),
        ButtonState.loading: IconedButton(
            text: "Cargando...", color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
            text: "Error",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      },
      onPressed: onPressedIconWithMinWidthStateText,
      state: stateTextWithIconMinWidthState,
      minWidthStates: [ButtonState.loading, ButtonState.success],
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  // void onPressedIconWithText() {
  //   switch (stateTextWithIcon) {
  //     case ButtonState.idle:
  //       stateTextWithIcon = ButtonState.loading;
  //       Future.delayed(Duration(seconds: 1), () {
  //         setState(() {
  //           stateTextWithIcon = Random.secure().nextBool()
  //               ? ButtonState.success
  //               : ButtonState.fail;
  //         });
  //       });

  //       break;
  //     case ButtonState.loading:
  //       break;
  //     case ButtonState.success:
  //       stateTextWithIcon = ButtonState.idle;
  //       break;
  //     case ButtonState.fail:
  //       stateTextWithIcon = ButtonState.idle;
  //       break;
  //   }
  //   setState(() {
  //     stateTextWithIcon = stateTextWithIcon;
  //   });
  // }
  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            stateTextWithIcon = ButtonState.success;
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => HomePage()));
            });
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIconMinWidthState = stateTextWithIconMinWidthState;
    });
  }
}
