import 'package:flutter/material.dart';

import 'data/candy_catalog.dart';
import 'models/candy.dart';
import 'models/cart_item.dart';
import 'screens/bag_screen.dart';
import 'screens/details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/shop_screen.dart';
import 'theme/app_theme.dart';

class CandyShopApp extends StatelessWidget {
  const CandyShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CandyLand',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const CandyShopShell(),
    );
  }
}

class CandyShopShell extends StatefulWidget {
  const CandyShopShell({super.key});

  @override
  State<CandyShopShell> createState() => _CandyShopShellState();
}

class _CandyShopShellState extends State<CandyShopShell> {
  int _currentIndex = 0;
  final List<CartItem> _cart = <CartItem>[];

  void _openDetails(Candy candy) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext routeContext) => CandyDetailsScreen(
          candy: candy,
          recommendations: candyCatalog
              .where((Candy item) => item.id != candy.id)
              .take(3)
              .toList(growable: false),
          onAddToBag: (int quantity) {
            _addToCart(candy, quantity);
            if (!mounted) {
              return;
            }

            setState(() {
              _currentIndex = 2;
            });

            Navigator.of(routeContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${candy.name} added to your sweet bag.'),
              ),
            );
          },
        ),
      ),
    );
  }

  void _addToCart(Candy candy, int quantity) {
    setState(() {
      final int existingIndex =
          _cart.indexWhere((CartItem item) => item.candy.id == candy.id);

      if (existingIndex == -1) {
        _cart.add(CartItem(candy: candy, quantity: quantity));
        return;
      }

      final CartItem existingItem = _cart[existingIndex];
      _cart[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    });
  }

  void _updateCartQuantity(String candyId, int delta) {
    setState(() {
      final int index =
          _cart.indexWhere((CartItem item) => item.candy.id == candyId);
      if (index == -1) {
        return;
      }

      final CartItem item = _cart[index];
      final int nextQuantity = item.quantity + delta;

      if (nextQuantity <= 0) {
        _cart.removeAt(index);
      } else {
        _cart[index] = item.copyWith(quantity: nextQuantity);
      }
    });
  }

  double get _cartSubtotal => _cart.fold<double>(
        0,
        (double sum, CartItem item) => sum + item.total,
      );

  int get _cartCount =>
      _cart.fold<int>(0, (int sum, CartItem item) => sum + item.quantity);

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          featuredCandies: candyCatalog.take(4).toList(growable: false),
          categories: candyCategories,
          onSelectCandy: _openDetails,
          onViewAll: () {
            setState(() {
              _currentIndex = 1;
            });
          },
        );
      case 1:
        return ShopScreen(
          candies: lolliesCatalog,
          onSelectCandy: _openDetails,
        );
      case 2:
        return BagScreen(
          cart: _cart,
          subtotal: _cartSubtotal,
          onUpdateQuantity: _updateCartQuantity,
          onContinueShopping: () {
            setState(() {
              _currentIndex = 1;
            });
          },
        );
      default:
        return const _AccountPlaceholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_rounded),
        ),
        title: const Text('CandyLand'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: KeyedSubtree(
            key: ValueKey<int>(_currentIndex),
            child: _buildCurrentScreen(),
          ),
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              backgroundColor: AppColors.berry,
              foregroundColor: Colors.white,
              child: const Icon(Icons.shopping_basket_rounded),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x1A93426E),
                blurRadius: 30,
                offset: Offset(0, -10),
              ),
            ],
          ),
          child: NavigationBar(
            height: 76,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedIndex: _currentIndex,
            onDestinationSelected: (int value) {
              setState(() {
                _currentIndex = value;
              });
            },
            destinations: <NavigationDestination>[
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.grid_view_rounded),
                selectedIcon: Icon(Icons.grid_view_rounded),
                label: 'Shop',
              ),
              NavigationDestination(
                icon: _BagIcon(itemCount: _cartCount, selected: false),
                selectedIcon: _BagIcon(itemCount: _cartCount, selected: true),
                label: 'Bag',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BagIcon extends StatelessWidget {
  const _BagIcon({
    required this.itemCount,
    required this.selected,
  });

  final int itemCount;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Icon(
          selected ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
        ),
        if (itemCount > 0)
          Positioned(
            top: -6,
            right: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.berry,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _AccountPlaceholder extends StatelessWidget {
  const _AccountPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[Color(0xFFFFEAF3), Color(0xFFFFF7DB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.account_circle_rounded, size: 64, color: AppColors.berry),
            SizedBox(height: 16),
            Text(
              'Account is next in line.',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.berry,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'This migration pass focused on storefront browsing, product details, and bag management. We can tackle auth, profiles, and checkout in the next iteration.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: AppColors.plumInk,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
