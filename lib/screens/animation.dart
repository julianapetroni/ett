import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Icon Demo'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                iconSize: 50,
                icon: Icon(isPlaying ? Icons.list : Icons.close),
                onPressed: () => _handleOnPressed(),
              ),
              IconButton(
                iconSize: 50,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                ),
                onPressed: () => _handleOnPressed(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}