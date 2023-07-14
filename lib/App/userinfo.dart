import 'dart:convert';
import 'package:contact/App/update.dart';
import 'package:contact/tools/dailog.dart';
import 'package:contact/tools/toaster.dart';
import 'package:contact/tools/loding.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Users extends StatefulWidget {
  const Users({super.key});
  @override
  State<Users> createState() => _Users();
}

class _Users extends State<Users> {
  String apiUrl = dotenv.env['API_URL']!;
  String apiendpointdelete = dotenv.env['API_ENDPOINT_DELETE']!;
  String apiendpointget = dotenv.env['API_ENDPOINT_GET']!;
  final logger = Logger();
  late List<Map<String, dynamic>> tableData = [];
  late bool isLoading = true;
  bool isDeleting = false;
  @override
  void initState() {
    super.initState();
    data();
  }

  @override
  void dispose() {
    tableData.clear();
    super.dispose();
  }

  // ignore: prefer_typing_uninitialized_variables
  var isdatas;
  Future data() async {
    var url = Uri.parse(apiUrl + apiendpointget);
    try {
      var res = await http.get(url);

      if (mounted) {
        if (res.statusCode == 200) {
          logger.d('Request successful');
          // logger.d(res.body.toString());
          var jsonData = jsonDecode(res.body) as List<dynamic>;
          // if (jsonData == null) {}
          setState(() {
            if (mounted) {
              isdatas = res.body == "[]";
              tableData = jsonData.cast<Map<String, dynamic>>();
              isLoading = false;
              isDeleting = false;
            }
          });
        } else {
          logger.d(res.body.toString());
          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }
        }
      }
    } catch (e) {
      logger.d(e.toString());
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
    }
  }

  void delete(id) async {
    setState(() {
      isDeleting = true; // Set loading state to true
    });
    try {
      var url = Uri.parse(apiUrl + apiendpointdelete + id);
      var res = await http.delete(url);

      var responseBody = jsonDecode(res.body);
      var message = responseBody['message'];

      if (res.statusCode == 200) {
        logger.d(res.body);
        // ignore: use_build_context_synchronously
        showToast(context, Colors.green, message);

        data();
      } else {
        logger.d(res.body);
        // ignore: use_build_context_synchronously
        showToast(context, Colors.red, message);
      }
    } on Exception catch (e) {
      logger.d(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('User Information'),
          backgroundColor: Colors.purple,
        ),
        body: Stack(children: [
          SingleChildScrollView(
              child: Container(
            height: screenHeight,
            width: screenWidth,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/formimage.jpg"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              // child: Expanded(
              child: Column(children: [
                // const Row(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(left: 30.0, bottom: 45),
                //       child: Text(
                //         "User Information",
                //         style: TextStyle(color: Colors.white, fontSize: 30),
                //       ),
                //     )
                //   ],
                // ),
                Container(
                    margin: const EdgeInsets.only(bottom: 90),
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
                                child: isdatas
                                    ? const Center(
                                        child: Text("Data is not available"),
                                      )
                                    : DataTable(
                                        columnSpacing: 20.0,

                                        headingRowHeight: 60.0,
                                        dividerThickness: 2.0,
                                        horizontalMargin: 10.0,

                                        // ignore: deprecated_member_use
                                        dataRowHeight: 56.0,
                                        columns: const [
                                          DataColumn(
                                            label: Text("S.no",
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ),
                                          DataColumn(
                                            label: Text("Name",
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ),
                                          DataColumn(
                                            label: Text("Email",
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ),
                                          DataColumn(
                                            label: Text("Phone",
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ),
                                          DataColumn(
                                            label: Text("Description",
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              "Actions",
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                        ],
                                        rows: tableData.map((rowData) {
                                          final serialNumber =
                                              (tableData.indexOf(rowData) + 1)
                                                  .toString();

                                          return DataRow(
                                            cells: [
                                              DataCell(Text(serialNumber)),
                                              DataCell(Text(
                                                  rowData['Name'].toString())),
                                              DataCell(Text(
                                                  rowData['Email'].toString())),
                                              DataCell(Text(
                                                  rowData['Phone'].toString())),
                                              DataCell(Text(
                                                  rowData['Disc'].toString())),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Update(
                                                                            alldata: {
                                                                              "Name": rowData['Name'].toString(),
                                                                              "Email": rowData['Email'].toString(),
                                                                              "Phone": rowData['Phone'].toString(),
                                                                              "Disc": rowData['Disc'].toString(),
                                                                              "id": rowData["_id"]
                                                                            })));
                                                        // Handle update action
                                                        // Here you can define the logic to perform when the update button is pressed
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      color: Colors.red,
                                                      onPressed: () async {
                                                        var title =
                                                            "Delete Data";
                                                        var message =
                                                            "You want to delete this data?";
                                                        dynamic result =
                                                            await dialog(
                                                                context,
                                                                title,
                                                                message);
                                                        if (result == true) {
                                                          delete(
                                                              rowData["_id"]);
                                                        } else {}
                                                        // Handle delete action
                                                        // Here you can define the logic to perform when the delete button is pressed
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                              ),
                      ),
                    )),
              ]),
              // ),
            ),
          )),
          if (isDeleting) const Loding()
        ]));
  }
}
