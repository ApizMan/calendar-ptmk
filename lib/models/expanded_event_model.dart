class ExpandedEventModel {
  String? name;
  String? matricId;
  String? refId;
  String? applyDate;
  String? leaveType;
  String? dateFrom;
  String? dateTo;
  String? totalDays;
  String? leaveReason;

  ExpandedEventModel(
      {this.name,
      this.matricId,
      this.refId,
      this.applyDate,
      this.leaveType,
      this.dateFrom,
      this.dateTo,
      this.totalDays,
      this.leaveReason});

  ExpandedEventModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    matricId = json['matricId'];
    refId = json['refId'];
    applyDate = json['applyDate'];
    leaveType = json['leaveType'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    totalDays = json['totalDays'];
    leaveReason = json['leaveReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['matricId'] = matricId;
    data['refId'] = refId;
    data['applyDate'] = applyDate;
    data['leaveType'] = leaveType;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['totalDays'] = totalDays;
    data['leaveReason'] = leaveReason;
    return data;
  }
}
