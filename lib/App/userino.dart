import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users extends StatefulWidget {
  const Users({super.key});
  @override
  State<Users> createState() => _Users();
}

class _Users extends State<Users> {
  late List<Map<String, dynamic>> tableData = [];
  late bool isLoading = true;
  @override
  void initState() {
    data();
    super.initState();
  }
   @override
  void dispose() {
    tableData.clear();
    super.dispose();
  }

  data() async {
    var url = Uri.parse("https://encouraging-hare-attire.cyclic.app/contacts");
     try {
      var res = await http.get(url);
      if (mounted) {
        if (res.statusCode == 200) {
          print('Request successful');
          print(res.body.toString());
          var jsonData = jsonDecode(res.body) as List<dynamic>;
          setState(() {
            if (mounted) {
              tableData = jsonData.cast<Map<String, dynamic>>();
              isLoading = false;
            }
          });
        } else {
          print(res.body.toString());
          // if (mounted) {
          //   setState(() {
          //     isLoading = false;
          //   });
          // }
        }
      }
    } catch (e) {
      print(e.toString());
      // if (mounted) {
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
    }
  }

 

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            constraints: BoxConstraints(maxWidth: screenWidth),
            child: Column(children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, bottom: 45),
                    child: Text(
                      "User Information",
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
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columnSpacing: 20.0,
    
                                headingRowHeight: 60.0,
                                dividerThickness: 2.0,
                                horizontalMargin: 10.0,
    
                                // ignore: deprecated_member_use
                                dataRowHeight: 56.0,
                                columns: const [
                                  DataColumn(
                                    label: Text("S.no",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                  DataColumn(
                                    label: Text("Name",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                  DataColumn(
                                    label: Text("Email",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                  DataColumn(
                                    label: Text("Phone",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                  DataColumn(
                                    label: Text("Description",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                ],
                                rows: tableData.map((rowData) {
                                  final serialNumber =
                                      (tableData.indexOf(rowData) + 1).toString();
    
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(serialNumber)),
                                      DataCell(Text(rowData['Name'].toString())),
                                      DataCell(Text(rowData['Email'].toString())),
                                      DataCell(Text(rowData['Phone'].toString())),
                                      DataCell(Text(rowData['Disc'].toString())),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                  )),
            ]),
          ),
        ),
      ))),
    );
  }
}
