import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_app/utils/calculator/custom_button.dart';
import 'canvas/border_canvas.dart';
import 'canvas/calculator_card_canvas.dart';
import 'notifiers.dart';
import 'constants.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('key'),
      direction: DismissDirection.down,
      onDismissed: (direction) => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 115,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(
                        top: 40,
                        left: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CS-IO',
                                style: GoogleFonts.michroma(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 5.0,
                                  height: 0.5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  'CALCULATOR',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              ...List.generate(
                                4,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, top: 20),
                                  child: CustomButton(
                                    height: 25,
                                    width: 25,
                                    borderRadius: 0,
                                    shadowOffset: const Offset(2, 2),
                                    borderWidth: 2.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0)
                          .copyWith(left: 15, right: 8),
                      child: Stack(
                        children: [
                          CustomPaint(
                            painter: ShadowCardCanvas(),
                            child: Container(),
                          ),
                          CustomPaint(
                            painter: CalculatorCardCanvas(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0).copyWith(
                                      left: 56,
                                      right: 20,
                                    ),
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          Notifiers.historyDisplayNotifier,
                                      builder: (context, value, child) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ...List.generate(
                                              value.length,
                                              (index) => FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  value[index],
                                                  style: GoogleFonts.bungee(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: SingleChildScrollView(
                                      // won't scroll idk why

                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      reverse: true,
                                      child: ValueListenableBuilder(
                                        valueListenable:
                                            Notifiers.screenDisplayNotifier,
                                        builder: (context, value, _) {
                                          String screenDisplayText =
                                              value == '' ? '0' : value;

                                          return Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            screenDisplayText,
                                            style: GoogleFonts.bungee(
                                              fontSize: 70,
                                              fontWeight: FontWeight.bold,
                                              color: screenDisplayText == '0'
                                                  ? Colors.grey
                                                  : Colors.black,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width - 30,
                                  color: KColors.actionColor?.withOpacity(0.5),
                                ),
                                Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width - 30,
                                  color: const Color.fromARGB(255, 236, 160, 48)
                                      .withOpacity(0.5),
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                          CustomPaint(
                            painter: BorderCanvas(),
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Flexible(
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: List.generate(
                    CalculatorKeys.calculatorKeys.length,
                    (index) {
                      return StaggeredGridTile.count(
                        crossAxisCellCount: index == 16 ? 2 : 1,
                        mainAxisCellCount: 1,
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: CustomButton(
                            buttonValue: CalculatorKeys.calculatorKeys[index]
                                [0],
                            buttonType: CalculatorKeys.calculatorKeys[index][2],
                            child: Center(
                              child: Text(
                                CalculatorKeys.calculatorKeys[index][0],
                                style: GoogleFonts.bungee(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: CalculatorKeys.calculatorKeys[index]
                                      [1],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
