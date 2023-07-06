class EntryData{
  String? name;
  double amount = 0;
  int timestamp = 0;
  String? description;

  EntryData({
    this.name,
    required this.amount,
    required this.timestamp,
    this.description
  });

  EntryData.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    amount = json["amount"];
    timestamp = json["timestamp"];
    description = json["description"];
  }
}