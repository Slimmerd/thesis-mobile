import 'package:thesis_mobile/core/model/volume_type.dart';

String volumeTypeParserSmall(volumeType) {
  switch (volumeType) {
    case VolumeType.grams:
      {
        return 'g';
      }

    case VolumeType.liters:
      {
        return 'ml';
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
        return 'kg';
      }

    case VolumeType.liters:
      {
        return 'l';
      }

    default:
      {
        throw ("Invalid choice");
      }
  }
}
