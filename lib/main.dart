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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rent House',
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
            icon: Icon(Icons.filter_alt_outlined),
          ),
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

  String bedRoom = "Any";
  String bathRoom = "Any";
  String homeType = "";
  String hostLanguage = "";

  Map<String, bool> equipments = {
    "Wifi": false,
    "Washer": false,
    "AC": false,
    "Smoking": false,
  };

  List languagesList = [
    "English",
    "Spanish",
    "French",
    "Russian",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 20,
            children: [
              /// ranger
              Column(
                children: [
                  Labels("Price Range"),
                  RangeSlider(
                    activeColor: Colors.black,
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
                    children: List.generate(
                      2,
                      (rangeItem) {
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
                      },
                    ),
                  ),
                ],
              ),

              /// bedroom and bathRooms
              Column(
                spacing: 10,
                children: List.generate(
                  2,
                  (roomIndex) {
                    List roomNames = ["Bed Rooms", "Bath Rooms"];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Labels(roomNames[roomIndex]),
                        Row(
                          spacing: 7,
                          children: List.generate(
                            7,
                            (index) {
                              List values = [
                                "Any",
                                "1",
                                "2",
                                "3",
                                "4",
                                "5",
                                "6+"
                              ];
                              return CustomCheckButton(
                                isSelected: bedRoom == values[index] &&
                                        roomIndex == 0 ||
                                    bathRoom == values[index] && roomIndex == 1,
                                value: values[index],
                                onTap: () {
                                  setState(
                                    () {
                                      if (roomIndex == 0) {
                                        bedRoom = values[index];
                                      } else if (roomIndex == 1) {
                                        bathRoom = values[index];
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),

              /// home && apartment
              Row(
                spacing: 20,
                children: List.generate(
                  2,
                  (index) {
                    List cardNames = ["House", "Apartment"];
                    List icons = [Icons.home, Icons.apartment];
                    return Expanded(
                      child: MaterialButton(
                        color: homeType == cardNames[index]
                            ? Colors.black
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          setState(() {
                            homeType = cardNames[index];
                          });
                        },
                        height: 120,
                        child: Column(
                          children: [
                            Icon(
                              icons[index],
                              color: homeType != cardNames[index]
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            Text(
                              cardNames[index],
                              style: TextStyle(
                                  color: homeType != cardNames[index]
                                      ? Colors.black
                                      : Colors.white),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// equipment
              Column(
                children: [
                  Labels("Equipment"),
                  Column(
                      children: equipments.keys.map((key) {
                    return CheckboxListTile(
                      // selectedTileColor: Colors.black,
                      // checkColor: Colors.black,
                      fillColor: MaterialStateProperty.all(
                          equipments[key] == true
                              ? Colors.black
                              : Colors.white),
                      title: Text(key),
                      value: equipments[key],
                      onChanged: (bool? value) {
                        setState(() {
                          equipments[key] = value!;
                          // print(equipments[key]);
                        });
                      },
                    );
                  }).toList()),
                ],
              ),

              /// host languages
              Column(
                children: [
                  Labels("Host Langauges"),
                  Column(
                      children: List.generate(languagesList.length, (index) {
                    return RadioListTile(
                      activeColor: Colors.black,
                      groupValue: hostLanguage,
                      title: Text(languagesList[index]),
                      value: languagesList[index],
                      onChanged: (value) {
                        setState(() {
                          hostLanguage = value;
                        });
                      },
                    );
                  })),
                ],
              ),

              /// submit button
              MaterialButton(
                color: Colors.black,
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                child: Text(
                  "Show Result",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCheckButton extends StatelessWidget {
  const CustomCheckButton(
      {super.key,
      required this.isSelected,
      required this.value,
      required this.onTap});

  final bool isSelected;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 5,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
            color: isSelected ? Colors.black : Colors.white),
        child: Text(
          value,
          style: TextStyle(
              fontSize: 18, color: !isSelected ? Colors.black : Colors.white),
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
