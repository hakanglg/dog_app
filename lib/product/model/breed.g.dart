// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Breed _$BreedFromJson(Map<String, dynamic> json) => Breed(
      breed: json['breed'] as String?,
      subBreeds: (json['subBreeds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$BreedToJson(Breed instance) => <String, dynamic>{
      'breed': instance.breed,
      'subBreeds': instance.subBreeds,
      'imageUrl': instance.imageUrl,
    };
