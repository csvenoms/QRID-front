import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/sharedPreference.dart';

enum GENDER { male, female }

enum Withdrawn { yes, no }

enum KindItems { foodOnly, beddingOnly, FoodAndBedding }

enum CashItems { foodOnly, beddingOnly, FoodAndBedding }

extension GENDERExtension on GENDER {
  String get name {
    return this.toString().split('.').last;
  }
}

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
late String name, id, batch, dept;

  Withdrawn? _withdraw = Withdrawn.no;
  KindItems? _kindItems = KindItems.FoodAndBedding;
  CashItems? _cashItems = CashItems.FoodAndBedding;

  DateTime selectedDate = DateTime.now();
  DateTime selectedBirthDate = DateTime.now();
  DateTime selectedWithdrawalDate = DateTime.now();
  String?
      selectedCountry; // Define selectedCountry as a property in the widget's state
  String? MothersselectedRegion;
  String?
      SchoolselectedRegion; // Define selectedCountry as a property in the widget's state
  String? departmentYear;
  String? department;
  int currentYear = DateTime.now().year;
  GENDER? _character = GENDER.male;
  final nationalityController = TextEditingController();
  String gender = '';

  @override
  void initState() {
    super.initState();
    AuthTokenSave.getFullName().then((value) {
      setState(() {
        name = value ?? "na full name found";
      });
    });
    AuthTokenSave.getbatch().then((value) {
      setState(() {
        batch = value ?? "na token found";
      });
    });
    AuthTokenSave.getId().then((value) {
      setState(() {
        id = value ?? "na id found";
      });
    });
    AuthTokenSave.getDept().then((value) {
      setState(() {
        dept = value ?? "no dept found";
      });
    });
    selectedCountry = 'Ethiopian';
    MothersselectedRegion = 'Select region';
    SchoolselectedRegion = 'Select region';
    departmentYear = 'II';
    department = 'Computer Science';
  }
void getStringGender() {
    switch (_character) {
      case GENDER.female:
        gender = "female";
        break;
      case GENDER.male:
        gender = "male";
        break;
      case null:
        break;
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedBirthDate = pickedDate;
      });
  }

  Future<void> _selectWithdrawalDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedWithdrawalDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedWithdrawalDate = pickedDate;
      });
  }

  Future<void> _selectCompleteDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return (batch== "2nd")?(SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Form(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        const SizedBox(height: 16),
                        const Text("Your Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0)),
                                width: 240,
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                width: 80,
                                height: 50,
                                child: Text(
                                  id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            width: 168,
                            child: Row(
                              children: <Widget>[
                                Column(
                                  children: [
                                    const Text("Gender"),
                                    Row(
                                      children: [
                                        Radio(
                                          value: GENDER.male,
                                          groupValue:
                                              _character, // Update group value accordingly
                                          onChanged: (GENDER? v) {
                                            setState(() {
                                              _character = v;
                                            });
                                          },
                                        ),
                                        const Text('Male'),
                                        Radio(
                                          value: GENDER.female,
                                          groupValue:
                                              _character, // Update group value accordingly
                                          onChanged: (GENDER? v) {
                                            setState(() {
                                              _character = v;
                                            });
                                          },
                                        ),
                                        const Text('Female')
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            width: 130,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () => _selectBirthDate(context),
                                  child: const Text('Select Date of birth'),
                                ),
                                Text(
                                    '${selectedBirthDate.day.toString()}/${selectedBirthDate.month.toString()}/${selectedBirthDate.year.toString()}'),
                              ],
                            ),
                          )
                        ]),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextFormField(
                            controller: nationalityController,
                            decoration: const InputDecoration(
                              hintText: 'Nationality',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text("Your Mother's/adopter's Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Full name',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              margin: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                items: <String>[
                                  'Select region',
                                  'Oromia',
                                  'Amhara',
                                  'Tigray',
                                  'SNNPR',
                                  'Afar',
                                  'Somali',
                                  'Sidama',
                                  'Harari',
                                  'Gambela',
                                  'Benshangule Gumuz',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  try {
                                    setState(() {
                                      MothersselectedRegion = value!;
                                    });
                                    print(
                                        'Selected region: $MothersselectedRegion');
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                },
                                value: MothersselectedRegion,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              width: 160,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Zone',
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 130,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Woreda',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 70,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Kebele',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 95,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'City/Town',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 130,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'House No.',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 70,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Phone No.',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 95,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'P o Box',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text("Preparatory school Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'School Name',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 80,
                                ),
                                TextButton(
                                  onPressed: () => _selectCompleteDate(context),
                                  child: const Text('Completion date'),
                                ),
                                Text(
                                    '${selectedDate.day.toString()}/${selectedDate.month.toString()}/${selectedDate.year.toString()}'),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              margin: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                items: <String>[
                                  'Select region',
                                  'Oromia',
                                  'Amhara',
                                  'Tigray',
                                  'SNNPR',
                                  'Afar',
                                  'Somali',
                                  'Sidama',
                                  'Harari',
                                  'Gambela',
                                  'Benshangule Gumuz',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  try {
                                    setState(() {
                                      SchoolselectedRegion = value!;
                                    });
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                },
                                value: SchoolselectedRegion,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              width: 160,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Zone',
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 130,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Woreda',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 70,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Kebele',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 95,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'City/Town',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                            "Collage Information \n Wolkite, Computing and Informatics College",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin: const EdgeInsets.only(
                                  top: 15.0, right: 8.0, left: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 80,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'entrance year',
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Dept' Year",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 70,
                                    child: Text(
                                      "$batch year",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin: const EdgeInsets.only(
                                  top: 15.0, left: 8.0, right: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 140,
                              child: Column(
                                children: [
                                  Text("${now.year}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                            child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Department",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    dept,
                                    style: TextStyle(fontSize: 24),
                                  )),
                            ],
                          ),
                        )),
                        const SizedBox(height: 16),
                        const Text("Have you ever withdrawn?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Radio(
                              value: Withdrawn.yes,
                              groupValue:
                                  _withdraw, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _withdraw = value;
                                });
                              },
                            ),
                            const Text('Yes'),
                            Radio(
                              value: Withdrawn.no,
                              groupValue:
                                  _withdraw, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _withdraw = value;
                                });
                              },
                            ),
                            const Text('No'),

                            (_withdraw == Withdrawn.yes)
                                ? (Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    width: 190,
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              _selectWithdrawalDate(context),
                                          child: const Text(
                                              'Select Date of Withdrawal'),
                                        ),
                                        Text(
                                            '${selectedWithdrawalDate.day.toString()}/${selectedWithdrawalDate.month.toString()}/${selectedWithdrawalDate.year.toString()}'),
                                      ],
                                    ),
                                  ))
                                : const Text(""),
//else display Text(""),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "What service would you demand?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('In Kind',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Radio(
                              value: KindItems.FoodAndBedding,
                              groupValue: _kindItems,
                              onChanged: (value) {
                                setState(() {
                                  _kindItems = value;
                                });
                              },
                            ),
                            const Text('Food and bedding'),
                            Radio(
                              value: KindItems.foodOnly,
                              groupValue: _kindItems,
                              onChanged: (value) {
                                setState(() {
                                  _kindItems = value;
                                });
                              },
                            ),
                            const Text('Food '),
                            Radio(
                              value: KindItems.beddingOnly,
                              groupValue:
                                  _kindItems, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _kindItems = value;
                                });
                              },
                            ),
                            const Text('Bedding '),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('In Cash',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Radio(
                              value: CashItems.FoodAndBedding,
                              groupValue: _cashItems,
                              onChanged: (value) {
                                setState(() {
                                  _cashItems = value;
                                });
                              },
                            ),
                            const Text('Food and bedding'),
                            Radio(
                              value: CashItems.foodOnly,
                              groupValue: _cashItems,
                              onChanged: (value) {
                                setState(() {
                                  _cashItems = value;
                                });
                              },
                            ),
                            const Text('Food '),
                            Radio(
                              value: CashItems.beddingOnly,
                              groupValue:
                                  _cashItems, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _cashItems = value;
                                });
                              },
                            ),
                            const Text('Bedding '),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20.0),
                          height: 68.0,
                          width: 500,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(
                                  32.0,
                                ),
                              ),
                            ),
                            onPressed: () {
                              getStringGender();
                             
                              Get.dialog(AlertDialog(
                                icon: const Icon(Icons.add_alert),
                                title:
                                    const Text("Alert \n Terms of agreement."),
                                content: const Text(
                                    "I agree in accordance with contractual agreement and higher education proclamation NO. 351/1995 and the higher edcation cost sharing regulation 154/2008 of the councile of MoSHE agree and accept this contract! This will be after graduation."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Agree'),
                                    onPressed: () {
                              
                                      Get.back();
                                    },
                                  ),
                                ],
                              ));
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ])),
                ),
               )
               ): (
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Text("your informatin",style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        Container(
                          width: 300,
                          child: Row(
                          children: [
                            Text(name, style: TextStyle(fontSize:22, fontWeight: FontWeight.bold),),
                            SizedBox(width: 8,),
                            Text(id, style: TextStyle(fontSize:22, fontWeight: FontWeight.bold))
                          ],
                        ),

                        ),
 const SizedBox(
                          height: 16,
                        ),
                        const Text(
                            "Collage Information \n Wolkite, Computing and Informatics College",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin: const EdgeInsets.only(
                                  top: 15.0, right: 8.0, left: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 80,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'entrance year',
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Dept' Year",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 70,
                                    child: Text(
                                      "$batch year",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin: const EdgeInsets.only(
                                  top: 15.0, left: 8.0, right: 8.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 140,
                              child: Column(
                                children: [
                                  Text("${now.year}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                            child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Department",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    dept,
                                    style: TextStyle(fontSize: 24),
                                  )),
                            ],
                          ),
                        )),
                        const SizedBox(height: 16),
                        const Text("Have you ever withdrawn?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Radio(
                              value: Withdrawn.yes,
                              groupValue:
                                  _withdraw, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _withdraw = value;
                                });
                              },
                            ),
                            const Text('Yes'),
                            Radio(
                              value: Withdrawn.no,
                              groupValue:
                                  _withdraw, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _withdraw = value;
                                });
                              },
                            ),
                            const Text('No'),

                            (_withdraw == Withdrawn.yes)
                                ? (Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    width: 190,
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              _selectWithdrawalDate(context),
                                          child: const Text(
                                              'Select Date of Withdrawal'),
                                        ),
                                        Text(
                                            '${selectedWithdrawalDate.day.toString()}/${selectedWithdrawalDate.month.toString()}/${selectedWithdrawalDate.year.toString()}'),
                                      ],
                                    ),
                                  ))
                                : const Text(""),
//else display Text(""),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "What service would you demand?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('In Kind',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Radio(
                              value: KindItems.FoodAndBedding,
                              groupValue: _kindItems,
                              onChanged: (value) {
                                setState(() {
                                  _kindItems = value;
                                });
                              },
                            ),
                            const Text('Food and bedding'),
                            Radio(
                              value: KindItems.foodOnly,
                              groupValue: _kindItems,
                              onChanged: (value) {
                                setState(() {
                                  _kindItems = value;
                                });
                              },
                            ),
                            const Text('Food '),
                            Radio(
                              value: KindItems.beddingOnly,
                              groupValue:
                                  _kindItems, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _kindItems = value;
                                });
                              },
                            ),
                            const Text('Bedding '),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('In Cash',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Radio(
                              value: CashItems.FoodAndBedding,
                              groupValue: _cashItems,
                              onChanged: (value) {
                                setState(() {
                                  _cashItems = value;
                                });
                              },
                            ),
                            const Text('Food and bedding'),
                            Radio(
                              value: CashItems.foodOnly,
                              groupValue: _cashItems,
                              onChanged: (value) {
                                setState(() {
                                  _cashItems = value;
                                });
                              },
                            ),
                            const Text('Food '),
                            Radio(
                              value: CashItems.beddingOnly,
                              groupValue:
                                  _cashItems, // Update group value accordingly
                              onChanged: (value) {
                                setState(() {
                                  _cashItems = value;
                                });
                              },
                            ),
                            const Text('Bedding '),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20.0),
                          height: 68.0,
                          width: 500,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(
                                  32.0,
                                ),
                              ),
                            ),
                            onPressed: () {
                              getStringGender();
                             
                              Get.dialog(AlertDialog(
                                icon: const Icon(Icons.add_alert),
                                title:
                                    const Text("Alert \n Terms of agreement."),
                                content: const Text(
                                    "I agree in accordance with contractual agreement and higher education proclamation NO. 351/1995 and the higher edcation cost sharing regulation 154/2008 of the councile of MoSHE agree and accept this contract! This will be after graduation."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Agree'),
                                    onPressed: () {
                              
                                      Get.back();
                                    },
                                  ),
                                ],
                              ));
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                    ),
                    )
               );
  }
}