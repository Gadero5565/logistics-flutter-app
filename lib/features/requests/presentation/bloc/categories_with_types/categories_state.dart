part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
}

final class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryWithTypesEntity> categories;

  const CategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({required this.message});

  @override
  List<Object> get props => [message];
}
