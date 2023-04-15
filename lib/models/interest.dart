var interests = <Interest>[];

class Interest {
  int id;
  String name;

  Interest({required this.id, required this.name});

  @override
  String toString() => 'Interest(id: $id, name: $name)';

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
