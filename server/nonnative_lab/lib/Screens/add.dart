import 'package:flutter/material.dart';

import '../Domain/Saving.dart';
import '../Aspects/constants.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(String stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }

    return true;
  }

  String nameValue = "";
  String categoryValue = "";
  String startDateValue = "";
  String endDateValue = "";
  String totalAmountValue = "";
  String monthlyAmountValue = "";
  List<String> categories = [
    "Travel",
    "Finance",
    "Shopping",
    "Home",
    "Education",
    "Automotive",
    "Health",
    "Technology",
    "Celebration",
    "Hobbies",
  ];

  @override
  void initState() {
    super.initState();
    // Use the first item in the categories list as the initial value
    categoryValue = categories.isNotEmpty ? categories[0] : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                const Text(
                  'Add Saving',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 20.0), // Spacer

                // Saving Name
                const Text(
                  'Saving Name',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill up all the fields!";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => nameValue = value,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.deepPurple,
                  ),
                ),

                SizedBox(height: 15.0),

                // Category
                const Text(
                  'Category',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 5.0),
                DropdownButtonFormField<String>(
                  value: categoryValue,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      categoryValue = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.deepPurple,
                  ),
                ),

                SizedBox(height: 15.0),

                // Start Date
                const Text(
                  'Start Date',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please add some text";
                    } else if (!isValidDate(value)) {
                      return "Use format: yyyy-MM-dd";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => startDateValue = value,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.deepPurple,
                  ),
                ),

                SizedBox(height: 15.0),

                // End Date
                const Text(
                  'End Date',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill up all the fields!";
                    } else if (!isValidDate(value)) {
                      return "Use format: yyyy-MM-dd";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => endDateValue = value,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.deepPurple,
                  ),
                ),

                SizedBox(height: 15.0),

                // Total Amount
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill up all the fields!";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => totalAmountValue = value,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.deepPurple,
                  ),
                ),

                SizedBox(height: 15.0),

                // Monthly Amount
                const Text(
                  'Monthly Amount',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill up all the fields!";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => monthlyAmountValue = value,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.deepPurple,
                  ),
                ),

                SizedBox(height: 30.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to FindAllState without saving
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pink,
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: AppColors.navyBlue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SomeFam',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, create and pop
                            Navigator.pop(
                              context,
                              Saving(
                                name: nameValue,
                                category: categoryValue,
                                initialDate: startDateValue,
                                endDate: endDateValue,
                                totalAmount: double.parse(totalAmountValue),
                                monthlyAmount: double.parse(monthlyAmountValue),
                                savedAmount: 0,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pink,
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: AppColors.navyBlue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SomeFam',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
