/// Selected value of DatePicker.
typedef DateValueCallback(DateTime dateTime, List<int> selectedIndex);

/// Pressed cancel callback.
typedef DateVoidCallback();

/// Default value of minimum datetime.
const String DATE_PICKER_MIN_DATETIME = "01-01-1900 00:00:00";

/// Default value of maximum datetime.
const String DATE_PICKER_MAX_DATETIME = "31-12-2100 23:59:59";

/// Default value of date format
const String DATETIME_PICKER_DATE_FORMAT = 'dd-MM-yyyy';

/// Default value of time format
const String DATETIME_PICKER_TIME_FORMAT = 'HH:mm:ss';

/// Default value of datetime format
const String DATETIME_PICKER_DATETIME_FORMAT = 'ddMMyyyy HH:mm:ss';