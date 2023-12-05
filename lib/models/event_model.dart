class Event {
  String? calendarapptid;
  String? startdate;
  String? starttime;
  String? enddate;
  String? endtime;
  String? reminderdate;
  String? description;
  String? agenda;
  String? location;

  Event(
      {this.calendarapptid,
      this.startdate,
      this.starttime,
      this.enddate,
      this.endtime,
      this.reminderdate,
      this.description,
      this.agenda,
      this.location});

  Event.fromJson(Map<String, dynamic> json) {
    calendarapptid = json['calendarapptid'];
    startdate = json['startdate'];
    starttime = json['starttime'];
    enddate = json['enddate'];
    endtime = json['endtime'];
    reminderdate = json['reminderdate'];
    description = json['description'];
    agenda = json['agenda'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calendarapptid'] = calendarapptid;
    data['startdate'] = startdate;
    data['starttime'] = starttime;
    data['enddate'] = enddate;
    data['endtime'] = endtime;
    data['reminderdate'] = reminderdate;
    data['description'] = description;
    data['agenda'] = agenda;
    data['location'] = location;
    return data;
  }

  @override
  String toString() {
    return 'Event{calendarapptid: $calendarapptid, startdate: $startdate, starttime: $starttime, enddate: $enddate, endtime: $endtime, reminderdate: $reminderdate, description: $description, agenda: $agenda, location: $location}';
  }
}
