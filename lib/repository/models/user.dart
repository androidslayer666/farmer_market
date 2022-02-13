import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String phone;
  String description;
  bool isSeller;
  String? avatarUrl;
  String? address;
  List<String>? products;
  List<String>? reviews;

  User({
    required this.name,
    required this.phone,
    required this.description,
    required this.isSeller,
    this.avatarUrl,
    this.address,
    this.products,
    this.reviews,
  });


  @override
  String toString() {
    return 'name : $name ;;; phone: $phone ;;; description $description';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

}