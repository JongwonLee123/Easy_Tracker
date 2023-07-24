// This class contains necessary functions
// fromJson() and toJson() used to read and write
// to and from the Database

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
    name = json["n"];
    amount = json["a"];
    timestamp = json["t"];
    description = json["d"];
  }

  Map<String, dynamic> toJson() {
    return {
      "n": name,
      "a": amount,
      "t": timestamp,
      "d": description
    };
  }
}