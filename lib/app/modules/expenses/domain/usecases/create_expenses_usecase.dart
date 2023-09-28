// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:js_interop';

import 'package:fpdart/fpdart.dart';

import 'package:expenses/app/modules/expenses/domain/entities/form_expenses.dart';
import 'package:expenses/app/modules/expenses/domain/errors/erros.dart';
import 'package:expenses/app/modules/expenses/domain/repositories/create_expenses_repository.dart';

abstract class ICreateExpenses {
  Either<ExpensesError, FormExpenses> call(FormExpenses expense);
}

class CreateExpenses implements ICreateExpenses {
  final ICreateExpensesRepository repository;

  CreateExpenses(this.repository);

  @override
  Either<ExpensesError, FormExpenses> call(FormExpenses expense)  {
    if (expense.title.isEmpty) {
      return Left(ExpensesError('Preencha todos os campos'));
    }
    return repository(expense);
  }
}
