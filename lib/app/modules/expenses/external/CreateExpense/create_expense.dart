import 'package:expenses/app/modules/expenses/domain/entities/form_expenses.dart';
import 'package:expenses/app/modules/expenses/domain/errors/erros.dart';
import 'package:expenses/app/modules/expenses/infra/datasources/expenses_datasource.dart';

class CreateExpense implements IExpensesDataSource {
  @override
  FormExpenses call(FormExpenses expenses) {
    if (expenses.title.isEmpty) {
      throw ExpensesError('O Título não pode estar nulo');
    }

    return expenses;
  }
}
