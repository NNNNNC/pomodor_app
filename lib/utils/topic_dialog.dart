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
      contentPadding: const EdgeInsets.only(left: 10.0, top: 18.0),
      title: Text(
        'Select Topic',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: widget.listofItems.map((topic) {
            return RadioListTile(
              title: Text(
                topic,
                style: const TextStyle(fontSize: 18),
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
            'DONE',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
