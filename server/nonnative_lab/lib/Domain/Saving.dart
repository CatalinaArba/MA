class Saving {
  static int currentId = 0;
  int? id;
  String name;
  String category;
  String initialDate;
  String endDate;
  double totalAmount;
  double monthlyAmount;
  double savedAmount;

  Saving(
      {this.id,
      required this.name,
      required this.category,
      required this.initialDate,
      required this.endDate,
      required this.totalAmount,
      required this.monthlyAmount,
      required this.savedAmount});

  // Saving.fromSaving(
  //   this.id,
  //   this.name,
  //   this.category,
  //   this.initialDate,
  //   this.endDate,
  //   this.totalAmount,
  //   this.monthlyAmount,
  //   this.savedAmount,
  // );

  // void updateValues({
  //   String? name,
  //   String? category,
  //   String? initialDate,
  //   String? endDate,
  //   double? totalAmount,
  //   double? monthlyAmount,
  //   double? savedAmount,
  // }) {
  //   this.name = name ?? this.name;
  //   this.category = category ?? this.category;
  //   this.initialDate = initialDate ?? this.initialDate;
  //   this.endDate = endDate ?? this.endDate;
  //   this.totalAmount = totalAmount ?? this.totalAmount;
  //   this.monthlyAmount = monthlyAmount ?? this.monthlyAmount;
  //   this.savedAmount = savedAmount ?? this.savedAmount;
  // }

  // static List<Saving> init() {
  //   List<Saving> savings = [
  //     Saving( 1,"Vacation Fund", "Travel", "2023-01-01", "2023-12-31", 5000.0, 400.0, 1200.0),
  //     Saving( 2,"Emergency Fund", "Finance", "2023-01-01", "2023-12-31", 10000.0, 800.0, 2000.0),
  //     Saving( 3,"Gadget Purchase", "Shopping", "2023-01-01", "2023-06-30", 2000.0, 400.0, 800.0),
  //     Saving( 4,"Home Renovation", "Home", "2023-01-01", "2023-12-31", 15000.0, 1200.0, 3500.0),
  //     Saving( 5,"Education Fund", "Education", "2023-01-01", "2023-12-31", 8000.0, 600.0, 2500.0),
  //     Saving( 6,"New Car", "Automotive", "2023-01-01", "2023-12-31", 12000.0, 1000.0, 3000.0),
  //     Saving( 7,"Fitness Equipment", "Health", "2023-01-01", "2023-12-31", 3000.0, 250.0, 800.0),
  //     Saving( 8,"Tech Upgrade", "Technology", "2023-01-01", "2023-06-30", 2500.0, 500.0, 1200.0),
  //     Saving( 9,"Gifts Fund", "Celebration", "2023-01-01", "2023-12-31", 1000.0, 100.0, 300.0),
  //     Saving( 10,"Hobby Expenses", "Hobbies", "2023-01-01", "2023-12-31", 2000.0, 150.0, 500.0),
  //   ];
  //   return savings;
  // }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'initialDate': initialDate,
        'endDate': endDate,
        'totalAmount': totalAmount,
        'monthlyAmount': monthlyAmount,
        'savedAmount': savedAmount,
      };

  factory Saving.fromJson(Map<String, dynamic> json) {
    return Saving(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      initialDate: json['initialDate'],
      endDate: json['endDate'],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      monthlyAmount: (json['monthlyAmount'] ?? 0).toDouble(),
      savedAmount: (json['savedAmount'] ?? 0).toDouble(),
    );
  }
}
