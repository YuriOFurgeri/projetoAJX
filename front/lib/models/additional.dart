class Additional {
  final int id;
  final bool addoption;
  final String notes;

  Additional({
   required this.id,
    required this.addoption,
    required this.notes,
  });

  factory Additional.fromJson(Map<String, dynamic> json) {
    return Additional(
      id: json['id'],
      addoption: json['addoption'] == 1,
      notes: json['notes'] ?? '',
    );
  }
}
