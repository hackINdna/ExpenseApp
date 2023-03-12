import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    var enteredTitle = textController.text;
    var enteredAmount = double.parse(
        amountController.text == "" ? "0.00" : amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.pop(context);
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'VarelaRound',
                  fontWeight: FontWeight.bold,
                ),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'VarelaRound',
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No date selected"
                            : "Picked Date: ${DateFormat.yMd().format(_selectedDate!)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'VarelaRound',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _selectDate,
                      child: const Text("Choose Date"),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: const Text(
                  "Add Transaction",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
