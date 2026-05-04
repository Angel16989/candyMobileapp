import 'package:flutter/material.dart';

import '../models/candy.dart';
import '../theme/app_theme.dart';
import '../widgets/candy_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    super.key,
    required this.candies,
    required this.onSelectCandy,
  });

  final List<Candy> candies;
  final ValueChanged<Candy> onSelectCandy;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Lollies',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.berry,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sweet, sour, and swirl-tastic pops for every mood.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.plumMuted,
            ),
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _FilterPill(label: 'Price'),
              _FilterPill(label: 'Flavor'),
              _FilterPill(label: 'Size'),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: candies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (BuildContext context, int index) {
              final Candy candy = candies[index];
              return CandyCard(
                candy: candy,
                onTap: () => onSelectCandy(candy),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x12A03C6C)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.plumInk,
        ),
      ),
    );
  }
}
