import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _pickedDate;

  void _submitInput() {
    if (amountController.text.isEmpty) {
      return;
    }

    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title == "" || amount <= 0 || _pickedDate == null) {
      return;
    }

    widget.addNewTransaction(title, amount, _pickedDate);
    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => _submitInput(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitInput(),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 7,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _pickedDate == null
                          ? 'No date choosen'
                          : 'Date choosen: ${DateFormat.yMd().format(_pickedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitInput,
              child: Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
