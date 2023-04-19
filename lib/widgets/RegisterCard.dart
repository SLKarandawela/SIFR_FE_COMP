import 'package:flutter/material.dart';

class MyPopupWidget extends StatefulWidget {
  @override
  _MyPopupWidgetState createState() => _MyPopupWidgetState();
  
}

class _MyPopupWidgetState extends State<MyPopupWidget> {
  


  late String _selectedValue;
  late DateTime _selectedDate = DateTime.now();

  TextEditingController _textController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  void _selectDate(BuildContext context) async {
    

    final DateTime? picked = await showDatePicker(
      
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text = _selectedDate.toString();
      });
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = 'Option 1';
    _dateController.text = _selectedDate?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('My Popup'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Full name',
            ),
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () => _selectDate(context),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Date of birth',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: _dateController,
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
            value: _selectedValue,
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue!;
              });
            },
            items: [
              DropdownMenuItem(
                child: Text('Male'),
                value: 'Option 1',
              ),
              DropdownMenuItem(
                child: Text('Female'),
                value: 'Option 2',
              ),
              DropdownMenuItem(
                child: Text('Other'),
                value: 'Option 3',
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Do something with the selected values
            print('Selected Text Field Value: ${_textController.text}');
            print('Selected Date: $_selectedDate');
            print('Selected Dropdown Value: $_selectedValue');
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
