import 'package:json_annotation/json_annotation.dart';

part 'breed.g.dart'; // Bu kısım modelinizin otomatik olarak üretilen dosyası için gerekli

@JsonSerializable()
class Breed {
  final String breed;
  final List<String> subBreeds;

  Breed({required this.breed, required this.subBreeds});

  // JSON'dan nesneye dönüştürme metodu
  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);

  // Nesneden JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() => _$BreedToJson(this);
}