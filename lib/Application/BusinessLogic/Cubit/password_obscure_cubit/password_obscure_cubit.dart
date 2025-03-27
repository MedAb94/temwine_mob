import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordObscureCubit extends Cubit<bool> {
  PasswordObscureCubit() : super(true);

  void enable() => emit(true);
  void disable() => emit(false);
}
