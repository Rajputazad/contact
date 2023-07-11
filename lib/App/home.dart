import 'dart:convert';
import 'package:contact/tools/loding.dart';
import 'package:logger/logger.dart';

import 'package:contact/App/userino.dart';
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late bool subimt = false;
  final logger = Logger();
  String apiUrl = dotenv.env['API_URL']!;
  String apiendpoint = dotenv.env['API_ENDPOINT_POST']!;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  String? _validname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (value.length < 3 || value.length > 20) {
      return "Enter a valid name";
    } else {
      return null;
    }
  }

  String? _validemali(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    } else if (!RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(value)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? _validphone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$')
        .hasMatch(value)) {
      return "Enter a valid phone number";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _desc.dispose();

    super.dispose();
  }

//  "https://encouraging-hare-attire.cyclic.app/receivecontact"
  Future<void> post() async {
    // var client = http.Client();

    if (_formkey.currentState!.validate()) {
    setState(() {
    subimt = true;
      
    });
      var uri = Uri.parse(apiUrl + apiendpoint);
      var data = {
        "Name": _name.text,
        "Email": _email.text,
        "Phone": _phone.text,
        "Disc": _desc.text,
      };
      // var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode(data);
      // logger.d(body);

      try {
        var res = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
        // logger.d(res.toString());
        if (res.statusCode == 200) {
          _formkey.currentState!.reset;
          _name.clear();
          _email.clear();
          _phone.clear();
          _desc.clear();
// ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
           setState(() {
    subimt = false;
      
    });
          logger.d('Request successful');
          logger.d(res.body.toString());
        } else {
          // ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
          logger.d(res.body.toString());
        }
      } catch (e) {
        FocusScope.of(context).unfocus();
        logger.d(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        // Define the behavior when the back button is pressed
        return true; // Return true to allow the app to be closed
      },
      child: Scaffold(
        body: Stack(
          children:[ SingleChildScrollView(
            child: Container(
              height: screenHeight,
              padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/formimage.jpg"),
                      fit: BoxFit.cover)),
              child: Column(children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, bottom: 45),
                      child: Text(
                        "Contact",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )
                  ],
                ),
                Container(
                  // height:500 ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all()
                  ),
        
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                "Name",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
        
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _name,
                                validator: _validname,
                                decoration: const InputDecoration(
                                  // contentPadding: EdgeInsets.symmetric(vertical: 0),
                                  // labelText: 'Name',
                                  hintText:
                                      'Enter your name..', // Add the hint text
                                ),
                              ),
                            ),
        
                            //  const SizedBox(height: 16),
        
                            const Text(
                              "Email",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
        
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _email,
                                validator: _validemali,
                                decoration: const InputDecoration(
                                  // labelText: 'Name',
                                  hintText:
                                      'Enter your email..', // Add the hint text
                                ),
                              ),
                            ),
                            const Text(
                              "Phone",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _phone,
                                validator: _validphone,
                                decoration: const InputDecoration(
                                  // labelText: 'Name',
                                  hintText: 'Enter your phone...',
                                  // Add the hint text
                                ),
                              ),
                            ),
        
                            const Text(
                              "Description",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _desc,
                                decoration: const InputDecoration(
                                  // labelText: 'Name',
                                  hintText: '(Optional)', // Add the hint text
                                ),
                              ),
                            ),
        
                            Row(
                              children: [
                              
                              
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, bottom: 30),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.purple,
                                                  Colors.orange
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Users()));
                                              },
                                              child: const Text(
                                                "Next",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),  const Spacer(),
                                  Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, bottom: 30),
                                  child: Align(
                                      // alignment: Alignment.centerRight,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.purple,
                                                  Colors.orange
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: TextButton(
                                              onPressed: () {
                                                post();
                                                
                                              },
                                              child: const Text(
                                                "Submit",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                )
              ]),
            ),
          ),
          if(subimt)
         const Loding()
          ]
        ),
      ),
    );
  }
}
