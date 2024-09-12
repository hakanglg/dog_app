extension CapitalizeFirstLetter on String {
  String capitalizeFirstLetter() {
    if (this == null || this.isEmpty) {
      return this; // Boş veya null metin için orijinal metni döndür
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}