import 'package:flutter/material.dart';

import '../models/candy.dart';
import '../theme/app_theme.dart';
import '../widgets/candy_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.featuredCandies,
    required this.categories,
    required this.onSelectCandy,
    required this.onViewAll,
  });

  final List<Candy> featuredCandies;
  final List<CandyCategory> categories;
  final ValueChanged<Candy> onSelectCandy;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _HeroBanner(onShopNow: onViewAll),
          const SizedBox(height: 28),
          Row(
            children: <Widget>[
              Text(
                'Sweet Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              TextButton(
                onPressed: onViewAll,
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories
                  .map(
                    (CandyCategory category) => Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: CategoryChip(category: category),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Daily Delights',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featuredCandies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (BuildContext context, int index) {
              final Candy candy = featuredCandies[index];
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

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.onShopNow,
  });

  final VoidCallback onShopNow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              'https://images.unsplash.com/photo-1534073133331-c4b62bf0d938?auto=format&fit=crop&q=80&w=1200',
              fit: BoxFit.cover,
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return Container(color: AppColors.berryPop);
              },
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xD993426E), Color(0x2293426E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xE6CABD64),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'SUMMER LIMITED',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                        color: Color(0xFF544C00),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sweet Summer Sale',
                    style: TextStyle(
                      fontSize: 30,
                      height: 1.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Get 20% off all gummies and stock up for the week.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFEE9F2),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: onShopNow,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.berry,
                    ),
                    child: const Text('Shop Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
