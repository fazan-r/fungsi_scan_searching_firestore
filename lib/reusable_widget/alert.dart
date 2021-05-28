import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showingAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
            String cancelActiontext,
  @required String defaultActionText,
})

{
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[

        if (cancelActiontext != null)
          CupertinoDialogAction(
            child: Text(cancelActiontext),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
