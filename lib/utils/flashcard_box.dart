import 'package:flutter/material.dart';

class FlashcardBox extends StatefulWidget {
  final String cardContent;
  final TextButton flipButton;
  final Function(String) onUpdateContent;

  const FlashcardBox(
      {Key? key, required this.cardContent, required this.flipButton, required this.onUpdateContent})
      : super(key: key);

  @override
  State<FlashcardBox> createState() => _FlashcardBoxState();
}

class _FlashcardBoxState extends State<FlashcardBox> {
  late TextEditingController _controller;
  bool _isEnable = false;



  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.cardContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _isEnable = false;
        },
        child: Container(
          width: 300,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEnable = true;
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Center(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    cursorColor: Color.fromRGBO(192, 192, 192, 1),
                    textAlign: TextAlign.center,
                    controller: _controller,
                    enabled: _isEnable,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      widget.onUpdateContent(value);
                    },
                    focusNode: FocusNode()
                      ..addListener(() {
                        if (!_controller.text.isNotEmpty) {
                          setState(() {
                            _isEnable = false;
                          });
                        }
                      }),
                  ),
                ),
                widget.flipButton
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 0,
                offset: const Offset(-4, 4),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
        ));
  }
}
