import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../theme/app_theme.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({
    super.key,
    required this.cart,
    required this.subtotal,
    required this.onUpdateQuantity,
    required this.onContinueShopping,
  });

  final List<CartItem> cart;
  final double subtotal;
  final void Function(String candyId, int delta) onUpdateQuantity;
  final VoidCallback onContinueShopping;

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.shopping_bag_rounded,
                  color: AppColors.berry,
                  size: 30,
                ),
                const SizedBox(width: 12),
                Text(
                  'Sweet Bag',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x1493426E),
                    blurRadius: 24,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  const Icon(
                    Icons.shopping_basket_rounded,
                    size: 64,
                    color: AppColors.berry,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your bag is empty.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Pick a few favorites and they will show up here ready for checkout.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.plumMuted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: onContinueShopping,
                    child: const Text('Go Shopping'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    const double deliveryFee = 1.50;
    final double total = subtotal + deliveryFee;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.shopping_bag_rounded,
                color: AppColors.berry,
                size: 30,
              ),
              const SizedBox(width: 12),
              Text(
                'Sweet Bag',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...cart.map(
            (CartItem item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _BagItemCard(
                item: item,
                onUpdateQuantity: onUpdateQuantity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              children: <Widget>[
                _SummaryRow(
                  label: 'Subtotal',
                  value: '\$${subtotal.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 12),
                const _SummaryRow(
                  label: 'Sweet Delivery',
                  value: '\$1.50',
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                _SummaryRow(
                  label: 'Total',
                  value: '\$${total.toStringAsFixed(2)}',
                  emphasize: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text('Place Sweet Order'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BagItemCard extends StatelessWidget {
  const _BagItemCard({
    required this.item,
    required this.onUpdateQuantity,
  });

  final CartItem item;
  final void Function(String candyId, int delta) onUpdateQuantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1493426E),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SizedBox(
              width: 88,
              height: 88,
              child: Image.network(
                item.candy.image,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.candy.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Flavor: ${item.candy.subcategory}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.plumMuted,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    _QuantityButton(
                      icon: Icons.remove_rounded,
                      onPressed: () =>
                          onUpdateQuantity(item.candy.id, -1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.berry,
                        ),
                      ),
                    ),
                    _QuantityButton(
                      icon: Icons.add_rounded,
                      onPressed: () =>
                          onUpdateQuantity(item.candy.id, 1),
                    ),
                    const Spacer(),
                    Text(
                      '\$${item.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.berry,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceSoft,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.berry, size: 18),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final TextStyle? baseStyle = emphasize
        ? Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.berry,
              fontWeight: FontWeight.w900,
            )
        : Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            );

    return Row(
      children: <Widget>[
        Text(label, style: baseStyle),
        const Spacer(),
        Text(value, style: baseStyle),
      ],
    );
  }
}
