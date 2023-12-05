import 'dart:convert';

import 'package:calendar_ptmk/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:calendar_ptmk/table_calendar.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../utils.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
  //     .toggledOff; // Can be toggled on/off by longpressing a date
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);

  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _selectedDay = null;
  //     _focusedDay = focusedDay;
  //     // _rangeStart = start;
  //     // _rangeEnd = end;
  //     // _rangeSelectionMode = RangeSelectionMode.toggledOn;
  //   });

  //   if (start != null && end != null) {
  //     _selectedEvents.value = _listOfDayEvents(start)
  //         .followedBy(
  //           daysInRange(start, end).skip(1).expand(_listOfDayEvents),
  //         )
  //         .toList();
  //   } else if (start != null) {
  //     _selectedEvents.value = _listOfDayEvents(start);
  //   } else if (end != null) {
  //     _selectedEvents.value = _listOfDayEvents(end);
  //   }
  // }

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

// Store the events created
  Map<String, List<Event>> mySelectedEvents = {};

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    fetchData();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  Future<void> fetchData() async {
    const String filePath = 'assets/json/calendar-data.json';
    final ByteData data = await rootBundle.load(filePath);
    final String jsonString = utf8.decode(data.buffer.asUint8List());

    final List<dynamic> jsonList = json.decode(jsonString);
    final List<Event> events =
        jsonList.map((json) => Event.fromJson(json)).toList();

    // Populate events in mySelectedEvents
    mySelectedEvents = {};
    for (final event in events) {
      final dateKey =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(event.startdate!));
      mySelectedEvents[dateKey] = mySelectedEvents[dateKey] ?? [];
      mySelectedEvents[dateKey]!.add(event);
    }

    setState(() {
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _listOfDayEvents(DateTime dateTime) {
    final formattedSelectedDay = DateFormat('yyyy-MM-dd').format(dateTime);

    return mySelectedEvents.entries
        .where((entry) {
          final startDate = DateTime.parse(entry.key);
          final endDate = DateTime.parse(entry.value.last.enddate!);
          return formattedSelectedDay == entry.key ||
              (startDate.isAtSameMomentAs(dateTime) ||
                  endDate.isAtSameMomentAs(dateTime) ||
                  (startDate.isBefore(dateTime) && endDate.isAfter(dateTime)));
        })
        .expand((entry) => entry.value)
        .toList();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Retrieve all event from the selected day
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null; // Important to clean those
        // _rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PTMK Calendar'),
      ),
      body: Column(
        children: [
          // Calendar Part
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            // rangeStartDay: _rangeStart,
            // rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            // rangeSelectionMode: _rangeSelectionMode,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            eventLoader: _listOfDayEvents,
            // onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),

          // Event Part
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  _listOfDayEvents(_selectedDay ?? DateTime.now()).length,
              itemBuilder: (context, index) {
                final myEvents =
                    _listOfDayEvents(_selectedDay ?? DateTime.now())[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${myEvents.starttime}',
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '${myEvents.description}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${myEvents.endtime}',
                                style: const TextStyle(),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '${myEvents.location}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Range Event Part
          // const SizedBox(height: 8.0),
          // Expanded(
          //   child: ValueListenableBuilder<List<Event>>(
          //     valueListenable: _selectedEvents,
          //     builder: (context, value, _) {
          //       return ListView.builder(
          //         itemCount: value.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: 12.0,
          //               vertical: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //             child: ListTile(
          //               onTap: () => print('${value[index].agenda}'),
          //               title: Text('${value[index].agenda}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
