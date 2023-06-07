import 'package:flutter/material.dart';

class DefaultTFF extends StatelessWidget {

  TextEditingController taskNameController;


  DefaultTFF({Key? key,required this.taskNameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: TextStyle(
          color: Colors.white, fontSize: 12),
      controller: taskNameController,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.amber.shade700,
              width: 2.0),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Colors.white10,
        hintText: 'New Task',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(
            top: 10, bottom: 10, left: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white10, width: 1.0),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.amber.shade700,
              width: 1.0),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)),
        ),
        labelText: "New Task",
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          Icons.title,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Task Name';
        } else {
          return null;
        }
      },
    );
  }
}
