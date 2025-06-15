import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projects/Views/widgets/keyboard_button.dart';

class TipView extends StatefulWidget {
  const TipView({super.key});

  @override
  State<TipView> createState() => _TipViewState();
}

class _TipViewState extends State<TipView> {
  TextEditingController billController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  bool isBillTotalSelected = true;
  int splitCount = 1;
  num splitTotal = 0;

  List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '/',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bill total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        isBillTotalSelected = true;
                      });
                    },
                    controller: billController,
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      // prefixText: '\$',
                      hintText: '0.00',
                      hintStyle: TextStyle(
                        fontSize: 34,
                        color: Colors.grey.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      // need only numbers and decimal point
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,10}')),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tip',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        isBillTotalSelected = false;
                      });
                    },
                    controller: tipController,
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      // need only numbers and decimal point
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,10}')),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0.00',
                      hintStyle: TextStyle(
                        fontSize: 34,
                        color: Colors.grey.withValues(alpha: 0.6),
                      ),
                      suffixText: '%',
                      // prefixText: '\$',
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Split',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                spacing: 16,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (splitCount > 1) {
                                        setState(() {
                                          splitCount--;
                                        });

                                        calculateSplitTotal();
                                      }
                                    },
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.teal.withValues(alpha: 0.1),
                                    ),
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.teal,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '$splitCount',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Increment logic here
                                      setState(() {
                                        splitCount++;
                                      });

                                      calculateSplitTotal();
                                    },
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.teal.withValues(alpha: 0.1),
                                    ),
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.teal,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Split total',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                splitTotal.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 1,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) => SizedBox(
              child: KeyboardButton(
                text: numbers[index],
                onPressed: () {
                  if(index == numbers.length - 1) {
                    billController.text = '';
                    tipController.text = '';
                    splitCount = 1;

                    calculateSplitTotal();
                  } else {
                    keyBoardButtonClicked(
                      text: numbers[index],
                    );
                  }
                },
              ),
            ),
          ),

          // /// numbers from 1 - 3
          // SizedBox(
          //   height: 70.0,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '1',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '1',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: double.infinity,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '2',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '2',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: double.infinity,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '3',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '3',
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: Colors.grey.withValues(alpha: 0.4),
          // ),
          // /// numbers from 4 - 6
          // SizedBox(
          //   height: 70.0,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '4',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '4',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 70,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '5',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '5',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 70,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '6',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '6',
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: Colors.grey.withValues(alpha: 0.4),
          // ),
          // /// numbers from 7 - 9
          // SizedBox(
          //   height: 70.0,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '7',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '7',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 70,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '8',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '8',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 70,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '9',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '9',
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: Colors.grey.withValues(alpha: 0.4),
          // ),
          // /// numbers from .,0 and /
          // SizedBox(
          //   height: 70.0,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '.',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '.',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 70,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '0',
          //           onPressed: () {
          //             keyBoardButtonClicked(
          //               text: '0',
          //             );
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 70,
          //         color: Colors.grey.withValues(alpha: 0.4),
          //       ),
          //       Expanded(
          //         child: KeyboardButton(
          //           text: '/',
          //           onPressed: () {
          //             billController.text = '';
          //             tipController.text = '';
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: Colors.grey.withValues(alpha: 0.4),
          // ),
          SizedBox(
            height: 70.0,
          ),
        ],
      ),
    );
  }

  void calculateSplitTotal() {
    double billAmount = double.tryParse(billController.text) ?? 0.0;
    double tipPercentage = double.tryParse(tipController.text) ?? 0.0;

    // Calculate the total amount including tip
    final totalAmount = billAmount + (billAmount * (tipPercentage / 100));

    // Calculate the split total
    splitTotal = totalAmount / splitCount;

    setState(() {});
  }

  void keyBoardButtonClicked({
    required String text,
  }) {
    if (isBillTotalSelected) {
      billController.text += text;
    } else {
      tipController.text += text;
    }

    calculateSplitTotal();
  }
}