import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  InputDialog({Key key, this.title});

  final String title;

  @override
  _InputDialogState createState() => _InputDialogState(title);
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _qtdController = TextEditingController();
  String _title;
  int qtd;

  _InputDialogState(String _title) {
    this._title = _title;
  }

  _btnOkClick() {
    if (_qtdController.text.isEmpty || int.parse(_qtdController.text) <= 0) {
      qtd = 0;
    } else {
      qtd = int.parse(_qtdController.text);
    }
    Navigator.pop(context);
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${this._title}'),
          content: TextField(
            controller: _qtdController,
            decoration: InputDecoration(hintText: "Quantidade"),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: _btnOkClick,
              child: Text("Ok"),
              color: Colors.green,
              textColor: Colors.white,
            ),
            FlatButton(
              onPressed: (){
                qtd = 0;
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}
