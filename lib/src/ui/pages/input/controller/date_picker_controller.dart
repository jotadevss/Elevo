import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Atom
final dateSelectedAtom = Atom<DateTime>(DateTime.now());

String get formattedDate {
  if (dateSelectedAtom.value == DateTime.now().day) {
    return 'Today';
  } else if (dateSelectedAtom.value == DateTime.now().day + 1) {
    return 'Tomorrow';
  } else if (dateSelectedAtom.value == DateTime.now().day - 1) {
    return 'Yesterday';
  } else {
    return DateFormat('dd/MM/yyyy').format(dateSelectedAtom.value);
  }
}

// Action
final showDatePickerAction = Atom<BuildContext?>(null);

// Reducer
class DatePickerController extends Reducer {
  DatePickerController() {
    on(() => [showDatePickerAction], () async {
      final context = showDatePickerAction.value!;
      dateSelectedAtom.value = await showDatePicker(
            context: context,
            initialDate: dateSelectedAtom.value,
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(2099),
          ) ??
          DateTime.now();
      createAtDataState.value = dateSelectedAtom.value;
    });
  }
}
