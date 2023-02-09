import 'package:thesis_mobile/core/model/order_status.dart';

String orderStatusParser(orderStatus) {
  switch (orderStatus) {
    case OrderStatus.waitingPayment:
      {
        return 'Waiting payment';
      }

    case OrderStatus.waitingWarehouse:
      {
        return 'Waiting response';
      }

    case OrderStatus.acceptedWarehouse:
      {
        return 'Preparing';
      }

    case OrderStatus.waitingCourier:
      {
        return 'Waiting courier';
      }

    case OrderStatus.delivering:
      {
        return 'Delivering';
      }

    case OrderStatus.delivered:
      {
        return 'Delivered';
      }

    case OrderStatus.rejected:
      {
        return 'Canceled';
      }

    default:
      {
        throw ("Invalid choice");
      }
  }
}
