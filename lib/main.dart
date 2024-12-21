import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppRouteName {
  static const String filter_page = "/filter_page";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        AppRouteName.filter_page: (context) => FilterPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouteName.filter_page);
              },
              icon: Icon(Icons.filter_alt_outlined))
        ],
      ),
    );
  }
}

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
    currentRangeValues = RangeValues(0, 100);
    rangeStartController = currentRangeValues.start.round().toString();
    rangeEndController = currentRangeValues.end.round().toString();
  }

  late RangeValues currentRangeValues;
  late String rangeStartController;
  late String rangeEndController;

  bool isSelected = false;

  void chooseNumsOfRooms({required List array, required String selectedItem}) {
    for (var i in array) {
      if (i == selectedItem) {
        // setState(() {
        // isSelected = true;
        print(true);
        // }
        // );
      } else {
        // setState(() {
        // isSelected = false;
        print(false);
        // }
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          children: [
            /// ranger
            Column(
              children: [
                Labels("Price Range"),
                RangeSlider(
                  max: 100,
                  divisions: 20,
                  values: currentRangeValues,
                  labels: RangeLabels(
                      currentRangeValues.start.round().toString(),
                      currentRangeValues.end.round().toString()),
                  onChanged: (value) {
                    setState(
                      () {
                        currentRangeValues = value;
                        rangeStartController =
                            currentRangeValues.start.round().toString();
                        rangeEndController =
                            currentRangeValues.end.round().toString();
                      },
                    );
                  },
                ),
                Row(
                  spacing: 20,
                  children: List.generate(2, (rangeItem){
                    List rangesList = [
                      rangeStartController,
                      rangeEndController
                    ];

                    return Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "\$${rangesList[rangeItem]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                )
              ],
            ),

            /// bedroom and bathRooms
            Column(
              spacing: 10,
              children: List.generate(2,
                  (roomIndex){

                List roomNames = [
                  "Bed Rooms",
                  "Bath Rooms"
                ];


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Labels(roomNames[roomIndex]),
                    Row(
                      spacing: 7,
                      children: List.generate(7, (bedRoomsCurrentIndex) {
                        List values = ["Any", "1", "2", "3", "4", "5", "6+"];
                        return InkWell(
                          radius: 5,
                          onTap: () {
                            // chooseNumsOfRooms(
                            //   array: values,
                            //   selectedItem: values[bedRoomsCurrentIndex],);
                            //
                            // print(bedRoomsCurrentIndex);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                                color: isSelected ? Colors.black : Colors.white),
                            child: Text(
                              values[bedRoomsCurrentIndex],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                );
                  }
              )
            )
          ],
        ),
      ),
    );
  }
}

class Labels extends StatelessWidget {
  const Labels(this.labelText, {super.key});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
