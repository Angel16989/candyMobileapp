import 'package:flutter/material.dart';

import '../models/candy.dart';
import '../theme/app_theme.dart';

class CandyDetailsScreen extends StatefulWidget {
  const CandyDetailsScreen({
    super.key,
    required this.candy,
    required this.recommendations,
    required this.onAddToBag,
  });

  final Candy candy;
  final List<Candy> recommendations;
  final ValueChanged<int> onAddToBag;

  @override
  State<CandyDetailsScreen> createState() => _CandyDetailsScreenState();
}

class _CandyDetailsScreenState extends State<CandyDetailsScreen> {
  int _quantity = 1;

  void _decrement() {
    if (_quantity == 1) {
      return;
    }

    setState(() {
      _quantity -= 1;
    });
  }

  void _increment() {
    setState(() {
      _quantity += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Candy candy = widget.candy;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CandyLand'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        candy.image,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return Container(
                            color: AppColors.surfaceSoft,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.cake_rounded,
                              color: AppColors.berry,
                              size: 60,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 18,
                        bottom: 18,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${candy.rating}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          candy.name,
                          style:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: AppColors.berry,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          candy.subcategory.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.mint,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x33FF9DCE),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      '\$${candy.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.berry,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                candy.description,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: AppColors.plumMuted,
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Select Quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.berry,
                        ),
                      ),
                    ),
                    _PillButton(
                      icon: Icons.remove_rounded,
                      onPressed: _decrement,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.berry,
                        ),
                      ),
                    ),
                    _PillButton(
                      icon: Icons.add_rounded,
                      onPressed: _increment,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => widget.onAddToBag(_quantity),
                  icon: const Icon(Icons.shopping_bag_rounded),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text('Add to Sweet Bag'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'You Might Also Like',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              Row(
                children: widget.recommendations
                    .map(
                      (Candy item) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                item.image,
                                fit: BoxFit.cover,
                                errorBuilder: (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) {
                                  return Container(
                                    color: AppColors.surfaceSoft,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.cake_rounded,
                                      color: AppColors.berry,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: AppColors.berry),
        ),
      ),
    );
  }
}
