import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String text;

  const TodoItem({@required this.text}) : assert(text != null);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            leading:
                const Radio(value: false, groupValue: null, onChanged: null),
            title: Text(text),
          ),
          const Divider(
            height: 1.0,
          )
        ],
      );
}
