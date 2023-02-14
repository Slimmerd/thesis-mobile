part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<int> ids;
  final List<CartProduct> items;
  final String key;
  final DeliveryType deliveryType;
  final String deliveryWindow;

  CartState({
    this.ids = const [],
    this.items = const [],
    this.deliveryType = DeliveryType.asap,
    this.deliveryWindow = '',
    this.key = '',
  });

  bool get isEmpty => total == 0;
  bool get notEmpty => total > 0;

  int get total {
    int total = 0;

    for (var item in items) {
      total += item.quantity;
    }

    return total;
  }

  int get totalPrice {
    int totalPrice = 0;

    for (var item in items) {
      totalPrice += item.totalPrice;
    }

    return totalPrice;
  }

  int get totalDeliveryPrice {
    int totalDelivery = 0;
    int totalCart = totalPrice;

    if (totalCart > 1200) {
      totalDelivery = 000;
    }

    if (totalCart < 1200) {
      totalDelivery = 199;
    }

    if (totalCart < 600) {
      totalDelivery = 399;
    }

    return totalDelivery;
  }

  int get serviceFee {
    int servicePrice = 0;
    int eco = ecoLevel;

    if (eco == 2) {
      servicePrice = 000;
    }

    if (eco == 1) {
      servicePrice = 150;
    }

    if (eco == 0) {
      servicePrice = 300;
    }

    return servicePrice;
  }

  int get ecoLevel {
    int level = 0;
    int totalCart = totalPrice;

    if (deliveryType == DeliveryType.asap && totalCart < 600) {
      level = 0;
    }

    if ((deliveryType == DeliveryType.sts ||
            deliveryType == DeliveryType.lts) ||
        totalCart > 600) {
      level = 1;
    }

    if (deliveryType == DeliveryType.lts && totalCart > 1200) {
      level = 2;
    }

    return level;
  }

  int count(Product product) {
    final id = product.id;

    if (ids.contains(id)) {
      final index = ids.indexOf(id);
      final item = items.elementAt(index);
      return item.quantity;
    }

    return 0;
  }

  int productTotal(Product product) {
    final id = product.id;

    if (ids.contains(id)) {
      final index = ids.indexOf(id);
      final item = items.elementAt(index);
      return item.totalPrice;
    }

    return 0;
  }

  bool has(int productID) {
    return ids.contains(productID);
  }

  CartProduct itemById(int id) {
    if (ids.contains(id)) {
      final index = ids.indexOf(id);
      final item = items.elementAt(index);
      return item;
    }
    throw Exception('No item');
  }

  CartProduct item(int index) => items[index];

  CartState reset() => copyWith(
        deliveryType: DeliveryType.asap,
        ids: [],
        items: [],
        key: '',
      );

  CartState add(CartProduct product) {
    return copyWith(
      deliveryType: deliveryType,
      ids: [...ids, product.product.id],
      items: [...items, product],
      key: Uuid().v1(),
    );
  }

  CartState updateOrderType(DeliveryType deliveryType) {
    return copyWith(deliveryType: deliveryType);
  }

  CartState updateOrderWindow(String deliveryWindow) {
    return copyWith(deliveryWindow: deliveryWindow);
  }

  CartState updateQuantity(int productID, int quantity) {
    if (has(productID)) {
      int index = ids.indexOf(productID);
      items.elementAt(index).quantity = quantity;
    }
    return copyWith(key: Uuid().v1());
  }

  CartState remove(int productID) {
    if (has(productID)) {
      int index = ids.indexOf(productID);
      ids.removeAt(index);
      items.removeAt(index);
    }

    if (isEmpty) {
      return reset();
    } else {
      return copyWith(key: Uuid().v1());
    }
  }

  CartState copyWith({
    List<int>? ids,
    List<CartProduct>? items,
    String? key,
    DeliveryType? deliveryType,
    String? deliveryWindow,
  }) {
    return CartState(
      deliveryType: deliveryType ?? this.deliveryType,
      ids: ids ?? this.ids,
      items: items ?? this.items,
      key: key ?? this.key,
      deliveryWindow: deliveryWindow ?? this.deliveryWindow,
    );
  }

  @override
  List<Object?> get props => [deliveryType, ids, items, key];
}
