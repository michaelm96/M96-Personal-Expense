import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: <Widget>[
                Text(
                  'No transaction found',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraint.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('Rp ${transactions[idx].amount}')),
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () {
                            deleteTx(transactions[idx].id);
                          },
                          icon: Icon(Icons.delete),
                          label: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTx(transactions[idx].id);
                          }),
                  title: Text(
                    transactions[idx].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(DateFormat('dd-MMMM-yyyy')
                      .format(transactions[idx].date)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
