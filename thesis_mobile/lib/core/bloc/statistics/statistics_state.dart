part of 'statistics_bloc.dart';

class StatisticsState extends Equatable {
  final String key;
  final double co2Saved;
  final double treesSaved;
  final int ordersMade;

  StatisticsState(
      {this.co2Saved = 0,
      this.treesSaved = 0,
      this.ordersMade = 0,
      this.key = ''});

  StatisticsState addOrder(Order order) {
    double _co2Saved = double.parse(
        (1.2 + ((1.2 / 100) * ecoPercent(order.ecoLevel))).toStringAsFixed(2));
    double _treesSaved = double.parse((_co2Saved / 21.77).toStringAsFixed(2));

    return copyWith(
      co2Saved: co2Saved + _co2Saved,
      treesSaved: treesSaved + _treesSaved,
      ordersMade: ordersMade + 1,
      key: Uuid().v1(),
    );
  }

  double ecoPercent(int ecoLevel) {
    if (ecoLevel == 1) {
      return 10;
    }

    if (ecoLevel == 2) {
      return 20;
    }

    return 0;
  }

  StatisticsState copyWith({
    String? key,
    double? co2Saved,
    double? treesSaved,
    int? ordersMade,
  }) {
    return StatisticsState(
        co2Saved: co2Saved ?? this.co2Saved,
        treesSaved: treesSaved ?? this.treesSaved,
        ordersMade: ordersMade ?? this.ordersMade,
        key: key ?? this.key);
  }

  @override
  List<Object?> get props => [co2Saved, treesSaved, ordersMade, key];
}
