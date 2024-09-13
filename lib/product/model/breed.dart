import 'package:json_annotation/json_annotation.dart';

part 'breed.g.dart';

@JsonSerializable()
class Breed {
  final String? breed;
  final List<String>? subBreeds;
  final String? imageUrl;

  Breed({
    required this.breed,
    required this.subBreeds,
    this.imageUrl = "",
  });

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
  Map<String, dynamic> toJson() => _$BreedToJson(this);
}