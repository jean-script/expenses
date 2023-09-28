import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    String title = _titleController.text;
    double value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty && value < 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
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
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                onSubmitted: (_) => _submitForm(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text('Selecionar Data'),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
