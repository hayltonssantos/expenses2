import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onRemove;

  const TransactionList(this.transaction, this.onRemove, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder( //bom para fazermos algo caber na tela
          builder: (ctx, constrains){
            return Column(
            children: <Widget>[
              SizedBox(height: 20), // espaçamento
              Text(
                'Nenhuma Transação Cadastrada!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: constrains.maxHeight * 0.05), // espaçamento
              SizedBox(
                height: constrains.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          );
          })
        : ListView.builder(
            itemCount: transaction.length, // tamanho da lista
            itemBuilder: (ctx, index) {
              final tr = transaction[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.remove_circle_outlined,
                      color: Colors.red,
                    ),
                    onPressed: () => onRemove(tr.id),
                  ),
                ),
              );
            },
          );
  }
}
