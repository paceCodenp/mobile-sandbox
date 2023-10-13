import 'package:flutter/material.dart';
import 'package:metgo_components/t_components.dart';
import 'package:metgo_resources/t_resources.dart';

class MgAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? customChild;

  final IconData? iconLeft;
  final IconData? iconRight;
  MgAppBar({Key? key, this.customChild, this.iconLeft, this.iconRight})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _MgAppBarState createState() => _MgAppBarState();
}

class _MgAppBarState extends State<MgAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Picture(
          source: Asset.icons.header,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
          colorFilter:
              ColorFilter.mode(Colors.blue.withOpacity(0.7), BlendMode.srcOver),
        ),
        widget.customChild ?? SizedBox(),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Icon(
              widget.iconLeft,
              size: 50,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Icon(
              widget.iconRight,
              size: 50,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "sadfasdfasdfasdfasdf  Name",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        )
      ],
    );
  }
}
