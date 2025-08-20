import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/error/failure_messages.dart';
import '../../../../../../core/services/encryptio_text.dart';
import '../../../../../../core/storage/app_storage.dart';
import '../../../domain/entities/login_entity.dart';
import '../../../domain/usecases/post_login_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static LoginBloc get(context) => BlocProvider.of(context);
  final PostLoginUseCase postLoginUseCase;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginBloc({required this.postLoginUseCase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PostLoginEvent) {
        try {
          emit(LoadingLoginState());
          final password = await encryptedText(event.password);
          final loginEntity = LoginEntity(
            email: event.email,
            password: password,
          );
          final failureOrResponse = await postLoginUseCase.call(loginEntity);
          failureOrResponse.fold(
            (failure) {
              emit(
                ErrorLoginState(
                  error: FailuresMessage().mapFailureToMessage(failure),
                ),
              );
            },
            (response) {
              AppStorage().setUserId(response.userId);
              AppStorage().setSecToken(response.secToken);
              emit(LoadedLoginState());
            },
          );
        } catch (e, stackTrace) {
          debugPrint('Error in PostLoginEvent: $e\n$stackTrace');
        }
      }
    });
  }
}
