import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../resources/app_assets.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          child: Lottie.asset(
            AppAssets.RAW_LOADING,
          ),
        );
      },
    );
  }

  static void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text("Oops"),
            content: const Text('Email or password may not correct!'),
            actions: [
              ElevatedButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
