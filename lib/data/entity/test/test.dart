class TestEntity {
  String? name;
  int? age;

  TestEntity({this.name, this.age});

  factory TestEntity.fromJson(Map<String, dynamic> json) {
    return TestEntity(
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
      };

  @override
  String toString() {
    return 'TestModel{name: $name, age: $age}';
  }
}
