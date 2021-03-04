import 'package:flutter/foundation.dart';

/// Calculates the percentage of a value within a given range of values
double percentageFromValueInRange(
    {@required final double min, @required max, @required value}) {
  return (value - min) / (max - min);
}
