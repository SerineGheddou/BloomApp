import 'package:flutter/material.dart';
import 'package:intl/message_lookup_by_library.dart';
String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

class FruitVegetable{
  late final String image,title,description;
  late final int id ;
  final Color color;

  FruitVegetable({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.color,
  });
}

List<FruitVegetable> FruitsVegetables = [
  FruitVegetable(
    id: 1,
    title: "Tomatos",
    description: dummyText,
    image: "img/tomatos.png",
    color: Color(0xbfff5757),
  ),
  FruitVegetable(
    id: 2,
    title: "Parsley",
    description: dummyText,
    image: "img/Parsley.png",
    color: Color(0xbf80F549),
  ),
  FruitVegetable(
    id: 3,
    title: "Tomatos",
    description: dummyText,
    image: "img/tomatos.png",
    color: Color(0xbfff5757),
  ),
  FruitVegetable(
    id: 4,
    title: "Parsley",
    description: dummyText,
    image: "img/Parsley.png",
    color: Color(0xbf80F549),
  ),
  FruitVegetable(
    id: 5,
    title: "Tomatos",
    description: dummyText,
    image: "img/tomatos.png",
    color: Color(0xbfFF5757),
  ),
  FruitVegetable(
    id: 6,
    title: "Parsley",
    description: dummyText,
    image: "img/Parsley.png",
    color: Color(0xbf80F549),
  ),
];

