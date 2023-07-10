import 'dart:convert';

import 'package:contact/App/userino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  Future<void> post() async {
    // var client = http.Client();
    var uri =
        Uri.parse("https://encouraging-hare-attire.cyclic.app/receivecontact");
    var data = {
      "Name": _name.text,
      "Email": _email.text,
      "Phone": _phone.text,
      "Disc": _desc.text,
    };
    // var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode(data);
    // print(body);

    try {
      var res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      // print(res.toString());
      if (res.statusCode == 200) {
        print('Request successful');
        print(res.body.toString());
      } else {
        print(res.body.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return  WillPopScope(
       onWillPop: () async {
         Navigator.pop(context);
        // Define the behavior when the back button is pressed
        return true; // Return true to allow the app to be closed
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  // border: Border.all()
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextField(
                            controller: _name,
                            decoration: const InputDecoration(
                              // labelText: 'Name',
                              hintText: 'Enter your name..', // Add the hint text
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Email",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: TextField(
                            controller: _email,
                            decoration: const InputDecoration(
                              // labelText: 'Name',
                              hintText: 'Enter your email..', // Add the hint text
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Phone",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: TextField(
                            controller: _phone,
                            decoration: const InputDecoration(
                              // labelText: 'Name',
                              hintText: 'Enter your phone...',
                              // Add the hint text
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Description",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextField(
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
                              padding: const EdgeInsets.only(top: 8.0, bottom: 30),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          gradient: const LinearGradient(
                                            colors: [Colors.purple, Colors.orange],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
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
                             Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      gradient: const LinearGradient(
                                        colors: [Colors.purple, Colors.orange],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Users()));
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
                        )
                          ],
                        ),
                       
                      ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
