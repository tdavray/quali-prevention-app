String formatCurrency(double amount) {
  // Convertit le nombre en string avec deux décimales
  String amountString = amount.toStringAsFixed(2);

  // Sépare la partie entière et les décimales
  List<String> parts = amountString.split('.');
  String integerPart = parts[0];
  String decimalPart = parts[1];

  // Ajoute les espaces pour chaque groupe de trois chiffres
  StringBuffer formatted = StringBuffer();
  for (int i = 0; i < integerPart.length; i++) {
    if (i != 0 && (integerPart.length - i) % 3 == 0) {
      formatted.write(' ');
    }
    formatted.write(integerPart[i]);
  }

  // Ajoute les décimales et le symbole €
  return '$formatted,$decimalPart €';
}

String formatDate(String date) {
  // Séparer la chaîne en mois et année
  List<String> parts = date.split('/');
  int month = int.parse(parts[0]);
  int year = int.parse('20${parts[1]}'); // Ajouter '20' pour l'année

  // Liste des mois en français
  List<String> months = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];

  // Retourner le mois formaté et l'année
  return '${months[month - 1]} $year';
}

String formatDateTime(String dateTimeString) {
  // Convertir la chaîne en DateTime
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Extraire les composants jour, mois et année
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  // Retourner la date au format 'dd/MM/yyyy'
  return '$day/$month/$year';
}
