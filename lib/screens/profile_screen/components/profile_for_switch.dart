import 'package:chat_bot/screens/profile_screen/components/switch.dart';
import 'package:flutter/material.dart';

class ProfileMenuSwitchWidget extends StatefulWidget {
  const ProfileMenuSwitchWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  State<ProfileMenuSwitchWidget> createState() =>
      _ProfileMenuSwitchWidgetState();
}

class _ProfileMenuSwitchWidgetState extends State<ProfileMenuSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.white;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 7),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black,
            ),
            child: Icon(
              widget.icon,
              color: iconColor,
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: widget.endIcon ? SwitchScreen() : null,
        ),
      ),
    );
  }
}
