import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  void toggleSwitch(bool value) {
    if (isSwitched == true) {
      setState(() {
        isSwitched = false;
      });
    } else {
      setState(() {
        isSwitched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: toggleSwitch,
      value: isSwitched,
      activeColor: Colors.white,
      activeTrackColor: Colors.lightBlueAccent,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey.shade700,
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackOutlineColor: MaterialStateProperty.all(Colors.black),
    );
  }
}
