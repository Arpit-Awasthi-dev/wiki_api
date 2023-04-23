import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

removeFocus(BuildContext context){
  FocusManager.instance.primaryFocus!.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}