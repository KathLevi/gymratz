import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

class DropdownMenu extends StatefulWidget {
  DropdownMenu({
    this.title,
    this.icon,
    this.content,
  });

  final String title;
  final IconData icon;
  final Widget content;

  @override
  State<StatefulWidget> createState() {
    return DropdownMenuState();
  }
}

class DropdownMenuState extends State<DropdownMenu> {
  bool expand = false;
  IconData icon;
  String title;

  @override
  void initState() {
    icon = widget.icon;
    title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          expand = !expand;
        });
      },
      child: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: grey))),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    size: xsIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: subheaderFont, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            ),
            expand
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 30.0),
                    child: widget.content)
                : Container()
          ],
        ),
      ),
    );
  }
}
