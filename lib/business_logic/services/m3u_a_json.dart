import 'dart:io';

Future<void> m3uToJson(String m3uFilePath, String outputJsonFilePath) async {
  try {
    // Lee el contenido del archivo M3U
    File m3uFile = File(m3uFilePath);
    List<String> lines = await m3uFile.readAsLines();

    // Lista para almacenar los canales
    List<Map<String, dynamic>> channels = [];

    // Variables temporales para almacenar la información del canal
    String? id;
    String? name;
    String? url;

    // Itera sobre las líneas del archivo M3U
    for (String line in lines) {
      // Ignora las líneas que comienzan con "#" (comentarios)
      if (line.startsWith('#EXTINF')) {
        // Extrae el nombre y la ID del canal
        List<String> parts = line.split(',');
        id = parts[0].split(':')[1];
        name = parts[1];
      } else if (line.isNotEmpty) {
        // Si la línea no está vacía, asume que es la URL del canal
        url = line;

        // Crea un mapa para representar el canal y agrégalo a la lista de canales
        channels.add({
          'id': id,
          'name': name,
          'website': url,
        });

        // Restablece las variables temporales para el próximo canal
        id = null;
        name = null;
        url = null;
      }
    }

    // Convierte la lista de canales a JSON
    String jsonContent = channels.toString();

    // Escribe el contenido JSON en un archivo de salida
    File outputJsonFile = File(outputJsonFilePath);
    await outputJsonFile.writeAsString(jsonContent);

    print('Conversión completada. Archivo JSON generado: $outputJsonFilePath');
  } catch (e) {
    print('Error al convertir el archivo M3U a JSON: $e');
  }
}

void main() {
  String m3uFilePath = 'canales.m3u';
  String outputJsonFilePath = 'canales.json';
  m3uToJson(m3uFilePath, outputJsonFilePath);
}
