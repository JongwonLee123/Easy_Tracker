class EntryData{
  int id = -1;
  String? name;
  double amount = 0;
  int timestamp = 0;
  String? description;

  EntryData({
    required this.id,
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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "amount": amount,
      "timestamp": timestamp,
      "description": description
    };
  }
}