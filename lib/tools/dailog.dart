import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

dynamic dialog(BuildContext context, String title, String message) async {
  return await showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return  ClassicGeneralDialogWidget(
        titleText: title,
        contentText: message,
        // onPositiveClick: () {
        //   Text("Ok");
        //   Navigator.of(context).pop(true);
        // },
        // onNegativeClick: () {
        //   Navigator.of(context).pop(false);
        // },
          actions: [
        ElevatedButton(
          style:ButtonStyle (backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          onPressed: () {
            // Perform some action
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
         ElevatedButton(
          style:ButtonStyle (backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
          onPressed: () {
            // Perform some action
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
          // style: ButtonStyle(backgroundColor: ),
        ),
      ],
      );
    },
    animationType: DialogTransitionType.slideFromTopFade,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 300),
  );
}
