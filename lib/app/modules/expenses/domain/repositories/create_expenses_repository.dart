import 'package:expenses/app/modules/expenses/domain/entities/form_expenses.dart';
import 'package:expenses/app/modules/expenses/domain/errors/erros.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICreateExpensesRepository {
  Either<ExpensesError, FormExpenses> call(FormExpenses expense);
}
