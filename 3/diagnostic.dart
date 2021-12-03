class Diagnostic {
  final List<String> input;
  late String gammaRate;
  late String epsillonRate;

  Diagnostic(this.input) {
    gammaRate = _gamma;
    epsillonRate = _epsilon;
  }

  // Get the bit at the index and position - 0 based.
  readBit(index, position) {
    return input[index][position];
  }

  int get consumption =>
      int.parse(gammaRate, radix: 2) * int.parse(epsillonRate, radix: 2);

  // int get lifeSupport => oxygen * co2

  String get _epsilon {
    String epsilon = '';

    for (var i = 0; i < gammaRate.length; i++) {
      epsilon = '$epsilon${(gammaRate[i] == '1' ? '0' : '1')}';
    }

    return epsilon;
  }

  String get _gamma {
    String gamma = '';
    int bitLength = input.first.length;
    for (var pos = 0; pos < bitLength; pos++) {
      int onCount = 0;
      int offCount = 0;
      for (var i = 0; i < input.length; i++) {
        final bit = readBit(i, pos);
        if (bit == '0') {
          offCount++;
        } else {
          onCount++;
        }
      }

      gamma = '$gamma${(onCount > offCount) ? 1 : 0}';
    }

    return gamma;
  }
}
