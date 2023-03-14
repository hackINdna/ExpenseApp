import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteFunction;
  const TransactionList(
      {super.key, required this.transactionList, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactionList.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/sleepingPerson.png",
                    scale: 3.5,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  "You don't have any transactions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactionList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            "\$${transactionList[index].amount.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  title: Text(
                    transactionList[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(transactionList[index].date)),
                  trailing: mediaQuery.size.width > 400
                      ? TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'VarelaRound'),
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      : IconButton(
                          onPressed: () =>
                              deleteFunction(transactionList[index].id),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                ),
              );
            },
          );
  }
}
