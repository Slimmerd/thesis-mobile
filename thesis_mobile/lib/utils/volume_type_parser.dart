import 'package:thesis_mobile/core/model/volume_type.dart';

String volumeTypeParserSmall(volumeType) {
  switch (volumeType) {
    case VolumeType.grams:
      {
        return 'г';
      }

    case VolumeType.liters:
      {
        return 'мл';
      }

    default:
      {
        throw ("Invalid choice");
      }
  }
}

String volumeTypeParserBig(volumeType) {
  switch (volumeType) {
    case VolumeType.grams:
      {
        return 'кг';
      }

    case VolumeType.liters:
      {
        return 'л';
      }

    default:
      {
        throw ("Invalid choice");
      }
  }
}
