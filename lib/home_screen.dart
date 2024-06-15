import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var yourMoneyController = TextEditingController();
  List<Map<String, String>> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Personal Expense',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter name";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter salary";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Salary',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            entries.add({
                              'name': controller1.text,
                              'salary': controller2.text
                            });
                            controller1.clear();
                            controller2.clear();
                            setState(() {});
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(60, 60),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showCalculateDialog(context);
                        },
                        child: Text(
                          'Calculate',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(60, 60),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${entries[index]['name']}',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Salary: ${entries[index]['salary']}',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _showCalculateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Calculate Salary Difference'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: yourMoneyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Your Money',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                double yourMoney = double.parse(yourMoneyController.text);
                double totalSalaries = entries.fold(
                    0, (sum, entry) => sum + double.parse(entry['salary']!));
                double difference = yourMoney - totalSalaries;

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Result'),
                      content: Text('Difference: $difference'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }
}
