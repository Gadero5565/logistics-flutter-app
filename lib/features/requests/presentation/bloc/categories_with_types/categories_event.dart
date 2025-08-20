part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class LoadCategoriesEvent extends CategoriesEvent {
  @override
  List<Object?> get props => [];
}