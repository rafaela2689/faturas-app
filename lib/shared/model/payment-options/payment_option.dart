class PaymentOption {

  PaymentOption({
    required this.number,
    required this.value,
    required this.total,
  });

  final int number;
  final double value;
  final double total;

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      number: json['number'] as int,
      value: (json['value'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  String get formatted => number.toString() + " x " + value.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentOption &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          value == other.value &&
          total == other.total;

  @override
  int get hashCode => number.hashCode ^ value.hashCode ^ total.hashCode;
}