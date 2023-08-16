enum Type {
  // Enums values with [Type Reference] string
  expense(type: 'despesas'),
  incomes(type: 'receitas');

  // Constructor for [Type Reference]
  final String type;
  const Type({required this.type});
}
