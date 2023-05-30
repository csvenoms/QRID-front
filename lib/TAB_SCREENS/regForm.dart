import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MODELS/Post.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../view/home.view.dart';
import '../view/sharedPreference.dart';

enum GENDER { male, female }

enum Withdrawn { yes, no }

enum Service { inCash, inKind, e }

enum CashkindItems { foodOnly, beddingOnly, FoodAndBedding, e }

enum Semister { I, II }

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
  late String name, id, batch, dept, email;

  Withdrawn? _withdraw = Withdrawn.no;
  Service? _kindItems = Service.e;
  CashkindItems? _cashItems = CashkindItems.e;
  Semister? _semister = Semister.I;
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
  final mothersnameController = TextEditingController();
  final mothersZoneController = TextEditingController();
  final mothersWoredaController = TextEditingController();
  final mothersKebeleController = TextEditingController();
  final mothersCityController = TextEditingController();
  final mothersHouseNoController = TextEditingController();
  final mothersPhoneNoController = TextEditingController();
  final mothersPOBoxController = TextEditingController();
  final schoolNameController = TextEditingController();
  final schoolZoneController = TextEditingController();
  final schoolWoredaController = TextEditingController();
  final schoolKebeleController = TextEditingController();
  final schoolCityController = TextEditingController();
  final collageEntranceYr = TextEditingController();

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
    AuthTokenSave.getEmail().then((value) {
      setState(() {
        email = value ?? "na email found";
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

  String semister = "";
  void getSemister() {
    switch (_semister) {
      case Semister.I:
        semister = "I";
        break;
      case Semister.II:
        semister = "II";
        break;
    }
  }

  String demandCashkind = "";
  void getDemandInCash() {
    switch (_cashItems) {
      case CashkindItems.FoodAndBedding:
        demandCashkind = "food and bedding";
        break;
      case CashkindItems.beddingOnly:
        demandCashkind = "bedding only";
        break;
      case CashkindItems.foodOnly:
        demandCashkind = "food only ";
        break;
    }
  }

  String demandKind = "";
  void getDemandKind() {
    switch (_kindItems) {
      case Service.inCash:
        demandKind = "Cash";
        break;
      case Service.inKind:
        demandKind = "Kind";
        break;
    }
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

  String dateOfBitrh = "";
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
        String a = selectedBirthDate.month.toString();
        if (a[0] != "1") {
          a = "0" + a;
        }

        dateOfBitrh = selectedBirthDate.year.toString() +
            "-" +
            a +
            "-" +
            selectedBirthDate.day.toString();
      });
  }

  String dateOfWithdrawal = "nan";
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
        String a = selectedWithdrawalDate.month.toString();
        if (a[0] != "1") {
          a = "0" + a;
        }
        dateOfWithdrawal = selectedWithdrawalDate.year.toString() +
            "-" +
            a +
            "-" +
            selectedWithdrawalDate.day.toString();
      });
  }

  String prepCompleteYr = "";
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
        String a = selectedDate.month.toString();
        if (a[0] != "1") {
          a = "0" + a;
        }
        prepCompleteYr = selectedDate.year.toString() +
            "-" +
            a +
            "-" +
            selectedDate.day.toString();
      });
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return (batch == "2nd")
        ? (SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            width: 240,
                            child: Text(
                              name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
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
                        controller: mothersnameController,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          width: 160,
                          child: TextFormField(
                            controller: mothersZoneController,
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
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 130,
                          child: TextFormField(
                            controller: mothersWoredaController,
                            decoration: const InputDecoration(
                              hintText: 'Woreda',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 70,
                          child: TextFormField(
                            controller: mothersKebeleController,
                            decoration: const InputDecoration(
                              hintText: 'Kebele',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 95,
                          child: TextFormField(
                            controller: mothersCityController,
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
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 130,
                          child: TextFormField(
                            controller: mothersHouseNoController,
                            decoration: const InputDecoration(
                              hintText: 'House No.',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 70,
                          child: TextFormField(
                            controller: mothersPhoneNoController,
                            decoration: const InputDecoration(
                              hintText: 'Phone No.',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 95,
                          child: TextFormField(
                            controller: mothersPOBoxController,
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
                        controller: schoolNameController,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          width: 160,
                          child: TextFormField(
                            controller: schoolZoneController,
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
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 130,
                          child: TextFormField(
                            controller: schoolWoredaController,
                            decoration: const InputDecoration(
                              hintText: 'Woreda',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 70,
                          child: TextFormField(
                            controller: schoolKebeleController,
                            decoration: const InputDecoration(
                              hintText: 'Kebele',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 95,
                          child: TextFormField(
                            controller: schoolCityController,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 80,
                          child: TextFormField(
                            controller: collageEntranceYr,
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
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
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
                                child: Text(
                                  "$batch year",
                                  style: const TextStyle(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 140,
                          child: Column(
                            children: [
                              Text("${now.year}",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: const EdgeInsets.only(
                            top: 15.0, left: 8.0, right: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: 140,
                        child: Column(
                          children: [
                            const Text("Semister"),
                            Row(
                              children: [
                                Radio(
                                  value: Semister.I,
                                  groupValue:
                                      _semister, // Update group value accordingly
                                  onChanged: (Semister? v) {
                                    setState(() {
                                      _semister = v;
                                    });
                                  },
                                ),
                                const Text('I'),
                                Radio(
                                  value: Semister.II,
                                  groupValue:
                                      _semister, // Update group value accordingly
                                  onChanged: (Semister? v) {
                                    setState(() {
                                      _semister = v;
                                    });
                                  },
                                ),
                                const Text('II')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        child: Center(
                      child: Column(
                        children: [
                          const Text(
                            "Department",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding: const EdgeInsets.only(left: 7),
                              child: Text(
                                dept,
                                style: const TextStyle(fontSize: 24),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0)),
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
                    const Text('Service',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Radio(
                          value: Service.inKind,
                          groupValue: _kindItems,
                          onChanged: (value) {
                            setState(() {
                              _kindItems = value;
                            });
                          },
                        ),
                        const Text('in Kind'),
                        Radio(
                          value: Service.inCash,
                          groupValue: _kindItems,
                          onChanged: (value) {
                            setState(() {
                              _kindItems = value;
                            });
                          },
                        ),
                        const Text('In cash '),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('demanded',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Radio(
                          value: CashkindItems.FoodAndBedding,
                          groupValue: _cashItems,
                          onChanged: (value) {
                            setState(() {
                              _cashItems = value;
                            });
                          },
                        ),
                        const Text('Food and bedding'),
                        Radio(
                          value: CashkindItems.foodOnly,
                          groupValue: _cashItems,
                          onChanged: (value) {
                            setState(() {
                              _cashItems = value;
                            });
                          },
                        ),
                        const Text('Food '),
                        Radio(
                          value: CashkindItems.beddingOnly,
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
                          getDemandInCash();
                          getDemandKind();
                          getSemister();
                          Get.dialog(AlertDialog(
                            icon: const Icon(Icons.add_alert),
                            title: const Text("Alert \n Terms of agreement."),
                            content: const Text(
                                "I agree in accordance with contractual agreement and higher education proclamation NO. 351/1995 and the higher edcation cost sharing regulation 154/2008 of the councile of MoSHE agree and accept this contract! This will be after graduation."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Agree'),
                                onPressed: () async {
                                  try {
                                    var jsontString =
                                        "{'email': '${email}','fullName': '$name','year':'$batch', 'sex': '$gender', 'date_of_birth': '${dateOfBitrh}', 'mothers_fullName': '${mothersnameController.text}', 'address_region': '${MothersselectedRegion}', 'address_zone': '${mothersZoneController.text}', 'address_woreda': '${mothersWoredaController.text}', 'address_kebele': '${mothersKebeleController.text}', 'adress_city': '${mothersCityController.text}', 'address_houseNo': '${mothersHouseNoController.text}', 'address_POBox': '${mothersPOBoxController.text}', 'prep_school_name': '${schoolNameController.text}', 'prep_complete_date': '${prepCompleteYr}', 'prep_school_region': '$SchoolselectedRegion', 'prep_school_zone': '${schoolZoneController.text}', 'prep_school_woreda': '${schoolWoredaController.text}', 'prep_school_kebele': '${schoolKebeleController.text}', 'prep_school_city':'${schoolCityController.text}', 'collage_join_year': '${collageEntranceYr.text}', 'department': '${department}', 'date_of_withdrawal': '${dateOfWithdrawal}', 'demanded_service': '${demandKind}', 'demand_Service_cashkind': '$demandCashkind', 'semister': '$semister'}";
                                    jsontString =
                                        jsontString.replaceAll("'", "\"");
                                    var jsonObject = json.decode(jsontString);
                                    final response = await http.post(
                                        Uri.parse(
                                            "${NetworkURL.URL}/registrar/courseRegistration"),
                                        body: jsonObject);
                                    if (response.statusCode == 201) {
                                      Get.snackbar("Success",
                                          "Registration Successfull! You can check you grade and next semister course in Results Tap!",
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP);
                                      AuthTokenSave.saveRegistrationStatus(
                                          "registered");
                                      Get.to(const HomePage());
                                    } else {
                                      var jsonObj = json.decode(response.body);
                                      Get.dialog(AlertDialog(
                                        title: const Text("error"),
                                        content: Text("${jsonObj['message']}"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.to(HomePage());
                                              },
                                              child: Text("ok"))
                                        ],
                                      ));
                                    }
                                  } catch (e) {
                                    Get.dialog(AlertDialog(
                                      title: const Text("error"),
                                      content: Text("$e"),
                                    ));
                                  }
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
          ))
        : (SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                const Text("your informatin",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(id,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold))
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            width: 70,
                            child: Text(
                              "$batch year",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: const EdgeInsets.only(
                          top: 15.0, left: 8.0, right: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 140,
                      child: Column(
                        children: [
                          Text("${now.year}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0)),
                    margin:
                        const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: 140,
                    child: Column(
                      children: [
                        const Text("Semister"),
                        Row(
                          children: [
                            Radio(
                              value: Semister.I,
                              groupValue:
                                  _semister, // Update group value accordingly
                              onChanged: (Semister? v) {
                                setState(() {
                                  _semister = v;
                                });
                              },
                            ),
                            const Text('I'),
                            Radio(
                              value: Semister.II,
                              groupValue:
                                  _semister, // Update group value accordingly
                              onChanged: (Semister? v) {
                                setState(() {
                                  _semister = v;
                                });
                              },
                            ),
                            const Text('II')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                    child: Center(
                  child: Column(
                    children: [
                      const Text(
                        "Department",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: const EdgeInsets.only(left: 7),
                          child: Text(
                            dept,
                            style: const TextStyle(fontSize: 24),
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
                      groupValue: _withdraw, // Update group value accordingly
                      onChanged: (value) {
                        setState(() {
                          _withdraw = value;
                        });
                      },
                    ),
                    const Text('Yes'),
                    Radio(
                      value: Withdrawn.no,
                      groupValue: _withdraw, // Update group value accordingly
                      onChanged: (value) {
                        setState(() {
                          _withdraw = value;
                        });
                      },
                    ),
                    const Text('No'),

                    (_withdraw == Withdrawn.yes)
                        ? (Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            width: 190,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      _selectWithdrawalDate(context),
                                  child:
                                      const Text('Select Date of Withdrawal'),
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
                const Text('Service',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio(
                      value: Service.inKind,
                      groupValue: _kindItems,
                      onChanged: (value) {
                        setState(() {
                          _kindItems = value;
                        });
                      },
                    ),
                    const Text('in kind'),
                    Radio(
                      value: Service.inCash,
                      groupValue: _kindItems,
                      onChanged: (value) {
                        setState(() {
                          _kindItems = value;
                        });
                      },
                    ),
                    const Text('InCash '),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('demanded',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio(
                      value: CashkindItems.FoodAndBedding,
                      groupValue: _cashItems,
                      onChanged: (value) {
                        setState(() {
                          _cashItems = value;
                        });
                      },
                    ),
                    const Text('Food and bedding'),
                    Radio(
                      value: CashkindItems.foodOnly,
                      groupValue: _cashItems,
                      onChanged: (value) {
                        setState(() {
                          _cashItems = value;
                        });
                      },
                    ),
                    const Text('Food '),
                    Radio(
                      value: CashkindItems.beddingOnly,
                      groupValue: _cashItems, // Update group value accordingly
                      onChanged: (value) {
                        setState(() {
                          _cashItems = value;
                        });
                      },
                    ),
                    const Text('Bedding '),
                  ],
                ),
                // Container(
                //   adding: const EdgeInsets.only(
                //       left: 30.0, right: 30.0, top: 20.0),
                //   height: 68.0,
                //   width: 500,
                //   child: Text("If you want to drop any course in this semister please contact the registrar office", style: ,),

                // ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
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
                      getDemandInCash();
                      getDemandKind();
                      getSemister();

                      Get.dialog(AlertDialog(
                        icon: const Icon(Icons.add_alert),
                        title: const Text("Alert \n Terms of agreement."),
                        content: const Text(
                            "I agree in accordance with contractual agreement and higher education proclamation NO. 351/1995 and the higher edcation cost sharing regulation 154/2008 of the councile of MoSHE agree and accept this contract! This will be after graduation."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Agree'),
                            onPressed: () async {
                              try {
                                String jsonString =
                                    "{'date_of_withdrawal':'${dateOfWithdrawal}', 'demanded_service':'${demandKind}','demand_Service_cashkind':'${demandCashkind}','estimated_cost':'0.0','date_of_advance_payment':'nan','semister':'$semister','year':'$batch'}";
                                jsonString = jsonString.replaceAll("'", "\"");
                                final url =
                                    '${NetworkURL.URL}/registrar/updateRegistrationData/$email'; // Replace with your API endpoint
                                final headers = {
                                  'Content-Type': 'application/json'
                                };
                                final body = json.encode(jsonString);

                                final response = await http.put(
                                  Uri.parse(url),
                                  headers: headers,
                                  body: body,
                                );
                                // Get.snackbar("title", "message");
                                if (response.statusCode == 200) {
                                  Get.snackbar("title",
                                      "registration complete successfully. you are now $batch year $semister student.",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white);

                                  Get.to(const HomePage());
                                } else {
                                  var jsonObj = json.decode(response.body);
                                  Get.dialog(AlertDialog(
                                    title: const Text("error"),
                                    content: Text("${jsonObj['message']}"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.to(HomePage());
                                          },
                                          child: Text("ok"))
                                    ],
                                  ));
                                }
                              } catch (e) {
                                Get.dialog(AlertDialog(
                                  content: Text("$e"),
                                ));
                              }
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
                const SizedBox(
                  height: 18,
                ),
                const Text("")
              ],
            )),
          ));
  }
}
