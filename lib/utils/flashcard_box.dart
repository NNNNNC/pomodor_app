import 'package:flutter/material.dart';

class FlashcardBox extends StatefulWidget {
  final String? cardContent;
  final TextButton flipButton;
  final Function(String)? onUpdateContent;
  final bool? isFlashcardEdit;
  final bool? isQuestion;

  const FlashcardBox({
    super.key,
    required this.cardContent,
    required this.flipButton,
    this.onUpdateContent,
    this.isFlashcardEdit,
    this.isQuestion,
  });

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
          height: 300,
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 0,
                offset: const Offset(0, 0),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
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
                      _isEnable = !_isEnable;
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  icon: Icon(
                    _isEnable ? Icons.edit : Icons.edit_off,
                    size: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Center(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    cursorColor: const Color.fromRGBO(192, 192, 192, 1),
                    textAlign: TextAlign.center,
                    controller: _controller,
                    enabled: _isEnable,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: (widget.isQuestion ?? false)
                          ? "Enter Question"
                          : "Enter Answer",
                    ),
                    onChanged: (value) {
                      widget.onUpdateContent!(value);
                    },
                  ),
                ),
                widget.flipButton
              ],
            ),
          ),
        ));
  }
}
