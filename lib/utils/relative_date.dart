import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

String relativeDate(DateTime date) {
  DateTime now = DateTime.now();
  if (DateUtils.isSameDay(date, now))
    return '오늘';
  else if (DateUtils.isSameDay(date, now.add(const Duration(days: 1))))
    return '내일';
  else if (DateUtils.isSameDay(date, now.subtract(const Duration(days: 1))))
    return '어제';
  else {
    String dayOfWeek = DateFormat('EEEE', 'ko_KR').format(date);
    DateTime firstDayOfWeek =
        DateTime(now.year, now.month, now.day - now.weekday + 1);
    DateTime firstDayOfNextWeek = firstDayOfWeek.add(const Duration(days: 7));
    DateTime firstDayOfNextNextWeek =
        firstDayOfNextWeek.add(const Duration(days: 7));
    if (date.isAfter(firstDayOfWeek) && date.isBefore(firstDayOfNextWeek)) {
      return '이번주 $dayOfWeek';
    } else if (date.isAfter(firstDayOfNextWeek) &&
        date.isBefore(firstDayOfNextNextWeek)) {
      return '다음주 $dayOfWeek';
    }
  }

  if (now.year == date.year)
    return DateFormat('MM.dd EEEE', 'ko_KR').format(date);
  else if (now.year + 1 == date.year)
    return '내년 ${DateFormat('MM.dd EEEE', 'ko_KR').format(date)}';
  else
    return DateFormat('yyyy.MM.dd EEEE', 'ko_KR').format(date);
}
