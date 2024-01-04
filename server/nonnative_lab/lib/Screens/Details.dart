import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nonnative_lab/Screens/update.dart';
import 'package:nonnative_lab/Server/SavingServer.dart';

import '../Aspects/constants.dart';
import '../Domain/Saving.dart';
import '../database/database_service.dart';

class DetailsScreen extends StatelessWidget {
  final Saving saving;
  final DatabaseService databaseService;
  final SavingAPI serverService;
  final Function(Saving) onDelete;
  final Function(Saving) onUpdate;

  DetailsScreen(
      {required this.saving,
      required this.databaseService,
      required this.serverService,
      required this.onDelete,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      // Change this to your desired background color
      body: Center(
        child: Container(
          height: 700,
          width: 350,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/details_background.png'),
              fit: BoxFit.cover,
            ), // Change this to your desired background color
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${saving.name}',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyBlue),
              ),

              // Add more Text widgets for other attributes
              Text('Category: ${saving.category}',
                  style:
                      const TextStyle(fontSize: 18, color: AppColors.navyBlue)),
              Text('Total Amount: \$${saving.totalAmount.toStringAsFixed(2)}',
                  style:
                      const TextStyle(fontSize: 18, color: AppColors.navyBlue)),
              Text('Saved: \$${saving.savedAmount.toStringAsFixed(2)}',
                  style:
                      const TextStyle(fontSize: 18, color: AppColors.navyBlue)),
              Text('Start Date: ${saving.initialDate}',
                  style:
                      const TextStyle(fontSize: 18, color: AppColors.navyBlue)),
              Text('End Date: ${saving.endDate}',
                  style:
                      const TextStyle(fontSize: 18, color: AppColors.navyBlue)),

              SizedBox(height: 300),

              // Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Saving updatedSaving = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateScreen(saving: saving)),
                      );
                      try {
                        if (await serverService.isNetworkConnected()) {
                          await serverService.updateSavingOnServer(saving);
                        }
                        await databaseService.update(updatedSaving);
                        onUpdate(updatedSaving);
                      } catch (error, stackTrace) {
                        print(error.toString() + " " + stackTrace.toString());
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pink,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: const Text('Edit',
                        style:
                            TextStyle(color: AppColors.navyBlue, fontSize: 20)),
                  ),

                  SizedBox(height: 16), // Add some spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      // Add your delete logic here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Delete"),
                            content: Text(
                                "Are you sure you want to delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    if (await serverService
                                        .isNetworkConnected()) {
                                      if (saving.id != null) {
                                        await serverService
                                            .deleteSavingFromServer(saving.id!);
                                      }
                                    }

                                    await databaseService.delete(saving);
                                    log("Successfully deleted from local db");
                                  } catch (error, stackTrace) {
                                    print(error.toString() +
                                        " " +
                                        stackTrace.toString());
                                  }
                                  onDelete(saving);
                                  Navigator.pop(context); // Close the dialog
                                  Navigator.pop(
                                      context); // Close the details page
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pink,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: const Text('Delete',
                        style:
                            TextStyle(color: AppColors.navyBlue, fontSize: 20)),
                  ),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pink,
                      minimumSize: Size(double.infinity,
                          50), // Set the minimum width and height
                    ),
                    child: const Text('Cancel',
                        style:
                            TextStyle(color: AppColors.navyBlue, fontSize: 20)),
                  ),
                  // Add some spacing between buttons
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
