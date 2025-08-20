import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure_messages.dart';
import '../../../domain/entities/category_with_types.dart';
import '../../../domain/usecases/get_categories.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesWithTypes getCategoriesWithTypes;

  CategoriesBloc({required this.getCategoriesWithTypes})
      : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      final result = await getCategoriesWithTypes();
      result.fold(
            (failure) => emit(CategoriesError(
            message: FailuresMessage().mapFailureToMessage(failure))),
            (categories) => emit(CategoriesLoaded(categories: categories)),
      );
    });
  }
}
