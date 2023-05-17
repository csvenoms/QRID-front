import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/view/my_text_field.dart';

class CourseRegistrationForm extends StatefulWidget {
  const CourseRegistrationForm({super.key});

  @override
  State<CourseRegistrationForm> createState() => Course_RegisterStarationForm();
}

class Course_RegisterStarationForm extends State<CourseRegistrationForm> {
  TextEditingController MNcotroller = TextEditingController();

  String? dropdownValue = 'Region';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course reigstration Fofrm"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
        
              
        child: Column(
          children: [
          SizedBox(height: 50,),
          Center(
            child: Row(
              children: [
                Text("Jon Doe"),
                SizedBox(
                  width: 5,
                ),
                Text("sex: M")
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              MyTextField(
                hint: "Mothers full name",
                obscureText: false,
                contrller: MNcotroller,
              ),
              SizedBox(
                width: 3,
              ),
              // DropdownButton(
              //   value: dropdownValue,
              //   items: <String>[
              //     'Addis Ababa',
              //     "Afar",
              //     "Amhara",
              //     "Benishangul Gumz",
              //     "Dire Dawa",
              //     "Gambela",
              //     "Oromia",
              //     "Sidama",
              //     "Somali",
              //     "South Nations",
              //     "Tigray"
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (String? value) {
              //     setState(() {
              //       dropdownValue = value;
              //     });
              //   },
              // )
            ],
          )
        ]
        ),
       ),
    );
  }
}
