import 'package:flutter/material.dart';

import '../models/candy.dart';

const List<CandyCategory> candyCategories = <CandyCategory>[
  CandyCategory(name: 'Gummies', icon: Icons.bubble_chart_rounded),
  CandyCategory(name: 'Chocolates', icon: Icons.inventory_2_rounded),
  CandyCategory(name: 'Lollies', icon: Icons.celebration_rounded),
  CandyCategory(name: 'Hard Candy', icon: Icons.diamond_rounded),
];

const List<Candy> candyCatalog = <Candy>[
  Candy(
    id: '1',
    name: 'Sour Hearts',
    category: 'Gummies',
    subcategory: 'Berry Mix',
    price: 4.50,
    image:
        'https://images.unsplash.com/photo-1581798459219-318e76aecc7b?auto=format&fit=crop&q=80&w=400',
    rating: 4.8,
    description:
        'A playful and artistic display of neon-colored heart-shaped gummy candies. Tangy and sweet.',
  ),
  Candy(
    id: '2',
    name: 'Gold Truffles',
    category: 'Chocolates',
    subcategory: 'Dark Choc',
    price: 6.99,
    image:
        'https://images.unsplash.com/photo-1548907040-4baa42d10919?auto=format&fit=crop&q=80&w=400',
    rating: 4.9,
    description:
        'Luscious dark chocolate truffles dusted with golden cocoa powder. A premium treat.',
  ),
  Candy(
    id: '3',
    name: 'Rainbow Swirl',
    category: 'Lollies',
    subcategory: 'Fruit Punch',
    price: 3.25,
    image:
        'https://images.unsplash.com/photo-1534073828943-f801091bb18c?auto=format&fit=crop&q=80&w=400',
    rating: 4.7,
    description:
        'Vibrant rainbow swirl lollipop with a glossy finish. Exuberant and nostalgic.',
    isPopular: true,
  ),
  Candy(
    id: '4',
    name: 'Cloud Puffs',
    category: 'Gummies',
    subcategory: 'Vanilla',
    price: 5.50,
    image:
        'https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?auto=format&fit=crop&q=80&w=400',
    rating: 4.5,
    description:
        'Bright, pastel-colored marshmallows shaped like stars and clouds. Soft and pillowy.',
  ),
  Candy(
    id: '5',
    name: 'Wild Berry Heart',
    category: 'Lollies',
    subcategory: 'Mixed Berry',
    price: 3.25,
    image:
        'https://images.unsplash.com/photo-1499195333224-3ce974eecfb4?auto=format&fit=crop&q=80&w=400',
    rating: 4.6,
    description: 'Deep berry red heart-shaped lollipop. Ethereal and bright.',
    isNew: true,
  ),
  Candy(
    id: '6',
    name: 'Rainbow Swirl Pop',
    category: 'Lollies',
    subcategory: 'Giant Series',
    price: 4.50,
    image:
        'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=400',
    rating: 4.9,
    description:
        'A massive swirl of fruity goodness that lasts forever. Hand-crafted with magic.',
  ),
];

List<Candy> get lolliesCatalog => candyCatalog
    .where((Candy candy) => candy.category == 'Lollies')
    .toList(growable: false);
