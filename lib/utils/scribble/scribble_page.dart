import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pomodoro_app/utils/scribble/color_button.dart';
import 'package:scribble/scribble.dart';
import 'package:value_notifier_tools/value_notifier_tools.dart';

class ScribblePage extends StatefulWidget {
  final ScribbleNotifier notifier;

  const ScribblePage({super.key, required this.notifier});

  @override
  State<ScribblePage> createState() => _ScribblePageState();
}

class _ScribblePageState extends State<ScribblePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<bool> showColorToolbar = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final settingBox = Hive.box('settings');
    bool paperEnabled = settingBox.get('enablePaper', defaultValue: false);

    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Scribble"),
        actions: _buildActions(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(top: 2),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    image: (paperEnabled)
                        ? DecorationImage(
                            image: AssetImage("assets/bg/lined_paper.jpg"),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )
                        : null,
                  ),
                  child: Scribble(
                    notifier: widget.notifier,
                    drawPen: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildToolbarToggleButton(context),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: _buildToolbar(context),
                    ),
                  ),
                  _buildEraserButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarToggleButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showColorToolbar,
      builder: (context, isColorToolbarVisible, _) {
        return IconButton(
          tooltip: isColorToolbarVisible ? "Strokes" : "Colors",
          icon: Icon(isColorToolbarVisible ? Icons.brush : Icons.palette),
          onPressed: () {
            showColorToolbar.value = !isColorToolbarVisible;
          },
        );
      },
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showColorToolbar,
      builder: (context, isColorToolbarVisible, _) {
        return isColorToolbarVisible
            ? _buildColorToolbar(context)
            : _buildStrokeToolbar(context);
      },
    );
  }

  List<Widget> _buildActions(context) {
    return [
      ValueListenableBuilder(
        valueListenable: widget.notifier,
        builder: (context, value, child) => IconButton(
          icon: child as Icon,
          tooltip: "Undo",
          onPressed: widget.notifier.canUndo ? widget.notifier.undo : null,
        ),
        child: const Icon(Icons.undo),
      ),
      ValueListenableBuilder(
        valueListenable: widget.notifier,
        builder: (context, value, child) => IconButton(
          icon: child as Icon,
          tooltip: "Redo",
          onPressed: widget.notifier.canRedo ? widget.notifier.redo : null,
        ),
        child: const Icon(Icons.redo),
      ),
      const SizedBox(width: 25),
      IconButton(
        icon: const Icon(CupertinoIcons.trash),
        tooltip: "Clear",
        onPressed: widget.notifier.clear,
      ),
      const SizedBox(width: 10),
    ];
  }

  Widget _buildStrokeToolbar(BuildContext context) {
    return ValueListenableBuilder<ScribbleState>(
      valueListenable: widget.notifier,
      builder: (context, state, _) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final w in widget.notifier.widths)
            _buildStrokeButton(
              context,
              strokeWidth: w,
              state: state,
            ),
        ],
      ),
    );
  }

  Widget _buildStrokeButton(
    BuildContext context, {
    required double strokeWidth,
    required ScribbleState state,
  }) {
    final selected = state.selectedWidth == strokeWidth;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Material(
        elevation: selected ? 4 : 0,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => widget.notifier.setStrokeWidth(strokeWidth),
          customBorder: const CircleBorder(),
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            width: strokeWidth * 2,
            height: strokeWidth * 2,
            decoration: BoxDecoration(
                color: state.map(
                  drawing: (s) => Color(s.selectedColor),
                  erasing: (_) => Colors.transparent,
                ),
                border: state.map(
                  drawing: (s) => selected
                      ? Border.all(
                          width: 5,
                          color: Color(s.selectedColor * 3),
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : null,
                  erasing: (_) => Border.all(width: 1),
                ),
                borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildColorToolbar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildColorButton(context, color: Colors.white),
        _buildColorButton(context, color: Colors.black),
        _buildColorButton(context, color: Colors.red),
        _buildColorButton(context, color: Colors.green),
        _buildColorButton(context, color: Colors.blue),
        _buildColorButton(context, color: Colors.yellow),
        _buildColorButton(context, color: Colors.purple),
        _buildColorButton(context, color: Colors.orange),
        _buildColorButton(context, color: Colors.brown),
        _buildColorButton(context, color: Colors.pink),
        _buildColorButton(context, color: Colors.grey),
        _buildColorButton(context, color: Colors.lightBlue),
        _buildColorButton(context, color: Colors.teal),
        _buildColorButton(context, color: Colors.lime),
        _buildColorButton(context, color: Colors.indigo),
        _buildColorButton(context, color: Colors.amber),
      ],
    );
  }

  Widget _buildEraserButton(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.notifier.select((value) => value is Erasing),
      builder: (context, value, child) => ColorButton(
        color: Colors.transparent,
        outlineColor: Colors.black,
        isActive: value,
        onPressed: () => widget.notifier.setEraser(),
        child: const Icon(Icons.cleaning_services),
      ),
    );
  }

  Widget _buildColorButton(
    BuildContext context, {
    required Color color,
  }) {
    return ValueListenableBuilder(
      valueListenable: widget.notifier.select(
          (value) => value is Drawing && value.selectedColor == color.value),
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ColorButton(
          color: color,
          isActive: value,
          onPressed: () => widget.notifier.setColor(color),
        ),
      ),
    );
  }
}
