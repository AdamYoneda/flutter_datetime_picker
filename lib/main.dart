import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart'
    as picker_theme;
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class CustomPicker extends picker.CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, super.locale}) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
            currentLeftIndex(), currentMiddleIndex(), currentRightIndex())
        : DateTime(currentTime.year, currentTime.month, currentTime.day,
            currentLeftIndex(), currentMiddleIndex(), currentRightIndex());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datetime Picker'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7),
                      theme: const picker.DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                child: const Text(
                  'show date picker(custom theme &date time range)',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now());
                },
                child: const Text(
                  'show time picker',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showTime12hPicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now());
                },
                child: const Text(
                  'show 12H time picker with AM/PM',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 5, 5, 20, 50),
                      maxTime: DateTime(2020, 6, 7, 05, 09), onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, locale: picker.LocaleType.zh);
                },
                child: const Text(
                  'show date time picker (Chinese)',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime(2008, 12, 31, 23, 12, 34));
                },
                child: const Text(
                  'show date time picker (English-America)',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),

            //-------------------------------------------------------------
            //-------------------------------------------------------------
            TextButton(
                onPressed: () {
                  const fontWeight = FontWeight.w500;
                  picker.DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    onChanged: (date) {
                      print(
                          'change $date in time zone ${date.timeZoneOffset.inHours}');
                    },
                    onConfirm: (date) {
                      print('confirm $date');
                    },
                    currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                    locale: picker.LocaleType.jp,
                    theme: picker_theme.DatePickerTheme(
                      cancelStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: fontWeight,
                        fontFamily:
                            GoogleFonts.notoSansJp(fontWeight: fontWeight)
                                .fontFamily,
                        fontFamilyFallback: [
                          GoogleFonts.notoSansJp(fontWeight: fontWeight)
                              .fontFamily,
                        ].whereType<String>().toList(),
                        fontSize: 16,
                      ),
                      doneStyle: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: fontWeight,
                        fontFamily:
                            GoogleFonts.notoSansJp(fontWeight: fontWeight)
                                .fontFamily,
                        fontFamilyFallback: [
                          GoogleFonts.notoSansJp(fontWeight: fontWeight)
                              .fontFamily,
                        ].whereType<String>().toList(),
                        fontSize: 16,
                      ),
                      itemStyle: TextStyle(
                        color: Colors.grey.shade900,
                        fontWeight: fontWeight,
                        fontFamily:
                            GoogleFonts.notoSansJp(fontWeight: fontWeight)
                                .fontFamily,
                        fontFamilyFallback: [
                          GoogleFonts.notoSansJp(fontWeight: fontWeight)
                              .fontFamily,
                        ].whereType<String>().toList(),
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'show date time picker (日本)',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                      locale: picker.LocaleType.ru);
                },
                child: const Text(
                  'show date time picker (Russian)',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      currentTime: DateTime.utc(2019, 12, 31, 23, 12, 34),
                      locale: picker.LocaleType.de);
                },
                child: const Text(
                  'show date time picker in UTC (German)',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showPicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      pickerModel: CustomPicker(currentTime: DateTime.now()),
                      locale: picker.LocaleType.en);
                },
                child: const Text(
                  'show custom time picker,\nyou can custom picker model like this',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}
