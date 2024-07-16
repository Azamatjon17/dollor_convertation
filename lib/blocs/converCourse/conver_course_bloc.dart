import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_event.dart';
import 'package:dollor_convertation/blocs/converCourse/conver_course_bloc_state.dart';
import 'package:dollor_convertation/services/convertation_http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverCourseBloc extends Bloc<ConverCourseBlocEvent, ConverCourseBlocState> {
  final ConvertationHttpService _convertationHttpService = ConvertationHttpService();
  ConverCourseBloc() : super(InitialConverState()) {
    on<GetConverEvent>(_getConverts);
    on<ConverToMoneyEvent>(_countMoney);
  }

  _getConverts(GetConverEvent event, emit) async {
    try {
      emit(LoadingConverState());
      final moneys = await _convertationHttpService.getCurses();
      emit(LoadedConverState(moneys: moneys));
    } catch (e) {
      emit(
        ErrorConverState(
          message: e.toString(),
        ),
      );
    }
  }

  _countMoney(ConverToMoneyEvent event, emit) {
     double result = event.moneyFrom / event.moneyTo * 10;
    result = result / 10;
    emit(CountConverState(result: result));
  }
}
