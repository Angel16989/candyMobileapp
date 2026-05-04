import 'candy.dart';

class CartItem {
  const CartItem({
    required this.candy,
    required this.quantity,
  });

  final Candy candy;
  final int quantity;

  double get total => candy.price * quantity;

  CartItem copyWith({
    Candy? candy,
    int? quantity,
  }) {
    return CartItem(
      candy: candy ?? this.candy,
      quantity: quantity ?? this.quantity,
    );
  }
}
