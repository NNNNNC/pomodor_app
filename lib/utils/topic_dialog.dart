import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final List<String> listofItems;

  const CustomDialog({
    Key? key,
    required this.listofItems,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Topic', style: Theme.of(context).textTheme.titleLarge,),
      content: SingleChildScrollView(
        child: Column(
          children: widget.listofItems.map((topic) {
            return RadioListTile(
              title: Text(
                topic,
                style: TextStyle(fontSize: 16),
              ),
              value: topic,
              groupValue: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              activeColor: Theme.of(context).colorScheme.secondary,
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedItem);
          },
          child: Text(
              'OK',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
      ],
    );
  }
}
