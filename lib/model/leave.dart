class Leave {
  String? numberId;
  String? leaveDate;
  int? leaveDays;
  String? note;

  Leave({this.numberId, this.leaveDate, this.leaveDays, this.note});

  Leave.fromJson(Map<String, dynamic> json) {
    numberId = json['number_id'];
    leaveDate = json['leave_date'];
    leaveDays = json['leave_days'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number_id'] = numberId;
    data['leave_date'] = leaveDate;
    data['leave_days'] = leaveDays;
    data['note'] = note;
    return data;
  }
}