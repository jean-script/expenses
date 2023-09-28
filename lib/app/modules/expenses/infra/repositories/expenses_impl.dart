// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenses/app/modules/expenses/domain/entities/form_expenses.dart';
import 'package:expenses/app/modules/expenses/domain/errors/erros.dart';
import 'package:expenses/app/modules/expenses/domain/repositories/create_expenses_repository.dart';
import 'package:expenses/app/modules/expenses/infra/datasources/expenses_datasource.dart';
import 'package:fpdart/src/either.dart';

class ExpensesRepositoryImpl implements ICreateExpensesRepository {
  final IExpensesDataSource _dataSource;

  ExpensesRepositoryImpl(
    this._dataSource,
  );

  @override
  Either<ExpensesError, FormExpenses> call(FormExpenses expense) {
    try {
      return Right(_dataSource(expense));
    } on ExpensesError catch (e) {
      return Left(e);
    } on Exception {
      return Left(ExpensesError('Error '));
    }
  }
}
