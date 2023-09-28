import 'package:expenses/app/modules/expenses/domain/entities/form_expenses.dart';

abstract class IExpensesDataSource {
  FormExpenses call(FormExpenses expenses);
}
