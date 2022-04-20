abstract class Functions {
  static final _regCheckers = [
    RegExp(r'/\d/'),
    RegExp(r'/[a-z]/'),
    RegExp(r'/[A-Z]/'),
    RegExp(r"/\W/")
  ];
  static calculatePasswordStrength(String pass) {
    var score = 0.0;
    if (pass.isEmpty) return score;

    // award every unique letter until 5 repetitions
    var letters = <String, double>{};
    for (var i = 0; i < pass.length; i++) {
      letters[pass[i]] = (letters[pass[i]] ?? 0) + 1;
      score += 9 / letters[pass[i]]!;
    }

    // bonus points for mixing it up
    var variations = {
      'digits': _regCheckers[0].hasMatch(pass),
      'lower': _regCheckers[0].hasMatch(pass),
      'upper': _regCheckers[0].hasMatch(pass),
      'nonWords': _regCheckers[0].hasMatch(pass),
    };

    var variationCount = 0;
    variations.forEach((_, value) => variationCount += (value == true) ? 9 : 0);
    score += (variationCount - 1) * 10;

    return (score * .01).clamp(0.0, 1.0);
  }
}
