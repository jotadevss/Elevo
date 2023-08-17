enum Frequency {
  // Enums values with [Frequency Reference] string
  daily(frequency: 'Todo dia'),
  monthly(frequency: 'Todo mês'),
  yearly(frequency: 'Todo ano');

  // Constructor for [Frequency Reference]
  final String frequency;
  const Frequency({required this.frequency});
}
