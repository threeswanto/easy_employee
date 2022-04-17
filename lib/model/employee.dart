class Employee {
  int? number;
  String? numberId;
  String? name;
  String? address;
  String? birthDate;
  String? joinDate;
  int? leaveDays;
  String? leaveDate;
  String? note;

  Employee(
      {this.number,
        this.numberId,
        this.name,
        this.address,
        this.birthDate,
        this.joinDate,
      this.leaveDays,
        this.leaveDate,
        this.note,
      });

  Employee.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    numberId = json['number_id'];
    name = json['name'];
    address = json['address'];
    birthDate = json['date_birth'];
    joinDate = json['join_date'];
    leaveDays = json['leave_days'];
    leaveDate = json['leave_date'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['number_id'] = numberId;
    data['name'] = name;
    data['address'] = address;
    data['date_birth'] = birthDate;
    data['join_date'] = joinDate;
    data['note'] = note;
    return data;
  }
}