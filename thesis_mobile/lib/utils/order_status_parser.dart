import 'package:thesis_mobile/core/model/order_status.dart';

String orderStatusParser(orderStatus) {
  switch (orderStatus) {
    case OrderStatus.waitingPayment:
      {
        return 'Ожидание платежа';
      }

    case OrderStatus.waitingWarehouse:
      {
        return 'Ожидание ответа';
      }

    case OrderStatus.acceptedWarehouse:
      {
        return 'Готовится';
      }

    case OrderStatus.waitingCourier:
      {
        return 'Ожидаем курьера';
      }

    case OrderStatus.delivering:
      {
        return 'В пути';
      }

    case OrderStatus.delivered:
      {
        return 'Доставлен';
      }

    case OrderStatus.rejected:
      {
        return 'Отменен';
      }

    default:
      {
        throw ("Invalid choice");
      }
  }
}
