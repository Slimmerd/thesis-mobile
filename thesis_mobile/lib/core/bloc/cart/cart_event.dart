part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAdded extends CartEvent {
  final CartProduct product;

  const CartAdded(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'CartAdded { product: $product }';
}

class CartQuantityUpdated extends CartEvent {
  final int productID;
  final int quantity;

  const CartQuantityUpdated(this.productID, this.quantity);

  @override
  List<Object> get props => [productID, quantity];

  @override
  String toString() =>
      'CartUpdated { product: $productID, quantity: $quantity }';
}

class CartDeliveryTypeUpdated extends CartEvent {
  final DeliveryType deliveryType;

  const CartDeliveryTypeUpdated(this.deliveryType);

  @override
  List<Object> get props => [deliveryType];

  @override
  String toString() => 'CartOrderTypeUpdated { type: $deliveryType }';
}

class CartDeliveryWindowUpdated extends CartEvent {
  final String deliveryWindow;

  const CartDeliveryWindowUpdated(this.deliveryWindow);

  @override
  List<Object> get props => [deliveryWindow];

  @override
  String toString() => 'CartDeliveryWindowUpdated { type: $deliveryWindow }';
}

class CartRemoved extends CartEvent {
  final int productID;

  const CartRemoved(this.productID);

  @override
  List<Object> get props => [productID];

  @override
  String toString() => 'CartRemoved { product: $productID }';
}

class CartCleared extends CartEvent {
  const CartCleared();
}
