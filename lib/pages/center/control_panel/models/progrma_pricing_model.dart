class ProgramPricing {
  final String price;
  final List<String> services;

  const ProgramPricing({
    this.price = '',
    this.services = const [],
  });

  // Copy with method for easy updates
  ProgramPricing copyWith({
    String? price,
    List<String>? services,
  }) {
    return ProgramPricing(
      price: price ?? this.price,
      services: services ?? this.services,
    );
  }
}
