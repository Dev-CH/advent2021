enum Criteria {
  common,
  oxygen,
  co2,
}

class Diagnostic {
  final List<String> input;
  late String gammaRate;
  late String epsillonRate;
  late String oxygenRate;
  late String co2Rate;

  Diagnostic(this.input) {
    gammaRate = _gamma;
    epsillonRate = _epsilon;
    oxygenRate = _oxygen;
    co2Rate = _co2;
  }

  int get consumption => _bitToInt(gammaRate) * _bitToInt(epsillonRate);

  int get lifeSupport => _bitToInt(oxygenRate) * _bitToInt(co2Rate);

  String get _epsilon {
    String epsilon = '';

    for (var i = 0; i < gammaRate.length; i++) {
      epsilon = '$epsilon${_flipBit(int.parse(gammaRate[i]))}';
    }

    return epsilon;
  }

  String get _gamma {
    String gamma = '';
    int bitLength = input.first.length;
    for (var pos = 0; pos < bitLength; pos++) {
      gamma = '$gamma${_readBit(pos, input)}';
    }

    return gamma;
  }

  String get _oxygen => _lifesupport(Criteria.oxygen);
  String get _co2 => _lifesupport(Criteria.co2);

  // Work out life support diagnostic based on criteria.
  String _lifesupport(Criteria criteria) {
    List<String> support = List.from(input);

    int bitLength = input.first.length;
    for (var pos = 0; pos < bitLength; pos++) {
      final bit = _readBit(pos, support, criteria);
      if (support.length > 1) {
        support.removeWhere((value) => value[pos] != bit.toString());
      }
    }

    return support.first;
  }

  // Get the bit at the index and position - 0 based
  // Change the logic based on the criteria passed
  _readBit(int position, range, [Criteria criteria = Criteria.common]) {
    int onCount = 0;
    int offCount = 0;
    for (var i = 0; i < range.length; i++) {
      final bit = range[i][position];

      if (bit == '0') {
        offCount++;
      } else {
        onCount++;
      }
    }

    if (criteria != Criteria.co2) {
      return (onCount >= offCount) ? 1 : 0;
    } else {
      return (onCount >= offCount) ? 0 : 1;
    }
  }

  // Flip the bit value
  _flipBit(int bit) => (bit == 1) ? 0 : 1;

  // Convert bit to int
  _bitToInt(String bit) => int.parse(bit, radix: 2);
}
