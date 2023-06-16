class TaskModel {
  int id;
  String name;
  int effortHours;
  double latitude;
  double longitude;
  DateTime date;

  TaskModel(
    this.id,
    this.name,
    this.effortHours,
    this.latitude,
    this.longitude,
    this.date);

  TaskModel.fromJson(int this.id, Map<String, dynamic> json)
      : name = json['name'],
        effortHours = json['effortHours'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'effortHours': effortHours,
    'latitude': latitude,
    'longitude': longitude,
    'date': date
  };
}
