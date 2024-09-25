import 'package:flutter/material.dart';


class ColorAndTextChangingButton extends StatefulWidget {
  @override
  _ColorAndTextChangingButtonState createState() =>
      _ColorAndTextChangingButtonState();
}

class _ColorAndTextChangingButtonState
    extends State<ColorAndTextChangingButton> {

  final List<Map<String, dynamic>> _buttonOptions = [
    {'color': Colors.blue, 'text': 'Bleu'},
    {'color': Colors.red, 'text': 'Rouge'},
    {'color': Colors.green, 'text': 'Vert'},
    {'color': Colors.orange, 'text': 'Orange'},
    {'color': Colors.purple, 'text': 'Violet'}
  ];

  int _currentIndex = 0;

  void _changeButton() {
    setState(() {

      _currentIndex = (_currentIndex + 1) % _buttonOptions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _changeButton,
          style: ElevatedButton.styleFrom(
            primary: _buttonOptions[_currentIndex]['color'], // Couleur du bouton
          ),
          child: Text(
            _buttonOptions[_currentIndex]['text'], // Texte du bouton
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
