// main_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nonnative_lab/Domain/Saving.dart';
import 'package:nonnative_lab/Server/SavingServer.dart';
import 'package:nonnative_lab/Aspects/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'Details.dart';
import 'add.dart';
import '../database/database_service.dart';

class FindAllScreen extends StatefulWidget {
  const FindAllScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FindAllState();
}

class FindAllState extends State<FindAllScreen> {
  late SavingAPI serverService=SavingAPI();
  late DatabaseService databaseService = DatabaseService.dbService;
  late List<Saving> savings;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkNetworkAndSyncData();

  }

  void checkNetworkStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult!=isConnected){
      showConnectionDialog(context, connectivityResult != ConnectivityResult.none);
    }
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  void getSavings() async {
    savings = await databaseService.getAllSavings();
  }

  void update(Saving newSaving) {
    setState(() {
      for (int i = 0; i < savings.length; i++) {
        if (savings[i].id == newSaving.id) {
          savings[i] = newSaving;
        }
      }
    });
  }

  void removeSaving(Saving saving) {
    setState(() {
      savings.removeWhere((element) => element.id == saving.id);
    });
  }

  void showConnectionDialog(BuildContext context, bool isConnected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connection Status'),
          content: Text(isConnected ? 'Connected' : 'Not Connected'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void checkNetworkAndSyncData() async {
    if (await serverService.isNetworkConnected()) {
      syncDataWithServer();
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }


  Future<void> syncDataWithServer() async {
    try {
      List<Saving> savingsFromServer = await serverService.getAllFromServer();
      log("data from server");
      for(Saving saving in savingsFromServer)
      {
        log(saving.id.toString() + " " + saving.name);
      }

      //getExpensesFromFuture();
      List<Saving> savingFromLocalDatabase = await databaseService.getAllSavings();
      log("data from db");
      for(Saving saving in savingFromLocalDatabase)
      {
        log(saving.id.toString() + " " + saving.name);
      }

      for (Saving s1 in savingFromLocalDatabase) {
        bool exists = savingsFromServer.any((s2) => s1.id == s2.id);

        if (!exists) {
          await serverService.addOnServer(s1);
          log("Added item from local db: "+s1.name);
        }
      }

      for (Saving s2 in savingsFromServer) {
        bool exists = savingFromLocalDatabase.any((s1) => s1.id == s2.id);

        if (!exists) {
          await serverService.deleteSavingFromServer(s2.id!);
          log("Deleted item from server: "+s2.name);
        }
      }

      for (Saving s1 in savingFromLocalDatabase) {
        bool different = savingsFromServer.any((s2) =>
        s1.id == s2.id &&
            (s1.name != s2.name ||
                s1.savedAmount != s2.savedAmount ||
                s1.initialDate != s2.initialDate ||
                s1.category != s2.category ||
                s1.endDate != s2.endDate ||
                s1.totalAmount != s2.totalAmount||
                s1.monthlyAmount != s2.monthlyAmount));

        if (different) {
          await serverService.updateSavingOnServer(s1);
          print("Updated item from the server: " +s1.name);
        }
        showSnackBar("Data was successfully synchronize with the server!");
      }
    } catch (e) {

      showSnackBar("Failed to synchronize data with the server!");
      print("Failed to synchronize data with the server: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    getSavings();
    return Directionality(
      textDirection: TextDirection.ltr, // Set your desired text direction
      child: Scaffold(
       body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 240,
              child: Container(
                color: AppColors.navyBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 30, 40),
                        child: Stack(
                          children: [
                            Container(
                              width: 400.0,
                              height: 240.0,
                              // Set the height of the inner container
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/main_information.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'This month',
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'November',
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Saving Global:',
                                              style: TextStyle(
                                                color: Colors.pink,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.pink,
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the border radius as needed
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        Saving saving = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddScreen()),
                                        );
                                        try {
                                          await databaseService.addSaving(
                                              saving);
                                          log("Successfully added on local db!");
                                          if (saving != null) {
                                            if(await serverService.isNetworkConnected()){
                                              await serverService.addOnServer(await databaseService.findByAttributesExceptId(saving));
                                            }
                                            setState(() {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text("Added!"),
                                              ));
                                              savings.add(saving);
                                            });
                                          }
                                        }
                                        catch(error, stackTrace){
                                          setState((){
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text("ERROR ADD!")));
                                          });
                                          print(error.toString()+" "+ stackTrace.toString());


                                        }

                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Add",
                                            style: TextStyle(
                                              color: AppColors.navyBlue,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'SomeFam',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  color: AppColors.navyBlue,
                  // child: ListView.builder(
                  //     padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  //     itemCount: savings.length,
                  //     itemBuilder: (context, index) {
                  //       return customCard(savings[index]);

                  child: _buildListSavings(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSavings() {
    return FutureBuilder(
      builder: (context, saving) {
        if (saving.connectionState == ConnectionState.none &&
            saving.connectionState == null) {
          return Container();
        } else if (!saving.hasData) {
          return Container();
        }
        return ListView.builder(
            itemCount: saving.data!.length,
            itemBuilder: (context, index) {
              return customCard(saving.data![index]);
            });
      },
      future: databaseService.getAllSavings(),
    );
  }
  // bool checkNetworkConnected()  {
  //   var connectivityResult = serverService.isNetworkConnected();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     showSnackBar("Connection Status: Not Connected");
  //     return false;
  //   }
  //   showSnackBar("Connection Status: Connected");
  //   return true;
  // }

  Widget customCard(Saving saving) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                  saving: saving,
                  databaseService:
                      databaseService,
                serverService: serverService,
                onDelete: removeSaving,
                onUpdate: update,), // Pass the saving object to the details page
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Container(
            color: AppColors.navyBlue,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.deepPurple,
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      saving.name,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      saving.category,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '\$${saving.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '\$${saving.savedAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

