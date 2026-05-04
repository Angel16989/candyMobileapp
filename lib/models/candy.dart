import 'package:flutter/material.dart';

class Candy {
  const Candy({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.image,
    required this.rating,
    required this.description,
    this.isPopular = false,
    this.isNew = false,
  });

  final String id;
  final String name;
  final String category;
  final String subcategory;
  final double price;
  final String image;
  final double rating;
  final String description;
  final bool isPopular;
  final bool isNew;
}

class CandyCategory {
  const CandyCategory({
    required this.name,
    required this.icon,
  });

  final String name;
  final IconData icon;
}
