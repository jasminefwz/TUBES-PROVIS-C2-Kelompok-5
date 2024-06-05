import 'package:flutter/material.dart'; // Import paket Flutter
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts untuk gaya teks

class Item {
  // Kelas untuk merepresentasikan item dalam daftar prosedur
  Item({
    // Konstruktor
    required this.headerText, // Teks untuk header item
    required this.expandedText, // Teks untuk konten yang diperluas
    this.isExpanded = false, // Status ekspansi item, defaultnya false
  });
  String headerText; // Teks untuk header item
  String expandedText; // Teks untuk konten yang diperluas
  bool isExpanded; // Status ekspansi item
}

class DetailPage extends StatefulWidget {
  // Widget stateful untuk halaman detail
  final String packageName; // Nama paket medis
  final String packageDescription; // Deskripsi paket medis
  final String packagePrice; // Harga paket medis
  final String packageDetail; // Detail paket medis

  const DetailPage({
    // Konstruktor
    Key? key,
    required this.packageName, // Nama paket medis
    required this.packageDescription, // Deskripsi paket medis
    required this.packagePrice, // Harga paket medis
    required this.packageDetail, // Detail paket medis
  }) : super(key: key);

  @override
  _DetailPageState createState() =>
      _DetailPageState(); // Membuat state untuk DetailPage
}

class _DetailPageState extends State<DetailPage> {
  // State untuk DetailPage
  final List<Map<String, dynamic>> _items = List.generate(
    // Daftar item prosedur
    2, // Jumlah item
    (index) => {
      "id": index,
      "title": "Item $index",
      "content": "konten ke $index",
    },
  );
  @override
  Widget build(BuildContext context) {
    // Membangun tampilan widget
    return Scaffold(
      // Scaffold sebagai kerangka utama
      appBar: AppBar(
        // App bar di bagian atas
        backgroundColor: Color(0xFF0068D7), // Warna latar belakang app bar
        title: Text(
          // Judul app bar
          'MEDICAL CHECK-UP', // Teks judul
          style: GoogleFonts.nunito(
            // Gaya teks menggunakan Google Fonts
            textStyle: TextStyle(
              fontWeight: FontWeight.bold, // Ketebalan teks
              fontSize: 20, // Ukuran teks
              color: Colors.white, // Warna teks
            ),
          ),
        ),
        centerTitle: true, // Menempatkan judul di tengah app bar
        leading: IconButton(
          // Tombol di sebelah kiri app bar
          icon: const Icon(
            Icons.arrow_back, // Ikon panah ke belakang
            color: Colors.white, // Warna ikon
          ),
          onPressed: () {
            // Aksi yang ingin dilakukan saat tombol panah kembali ditekan
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        toolbarHeight: 87, // Tinggi toolbar
      ),
      body: ListView(
        // Isi halaman, bisa di-scroll
        children: [
          Padding(
            // Padding di sekitar isi halaman
            padding: const EdgeInsets.all(5.0),
            child: Column(
              // Widget kolom untuk menyusun elemen secara vertikal
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Susunan elemen mulai dari kiri ke kanan
              children: [
                Text(
                  // Teks untuk nama paket medis
                  widget.packageName, // Nama paket medis
                  style: GoogleFonts.nunito(
                    // Gaya teks menggunakan Google Fonts
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, // Ketebalan teks
                      wordSpacing: 2, // Spasi antar kata
                      fontSize: 40, // Ukuran teks
                    ),
                  ),
                ),
                Text(
                  // Teks untuk deskripsi paket medis
                  widget.packageDescription, // Deskripsi paket medis
                  style: GoogleFonts.nunito(
                    // Gaya teks menggunakan Google Fonts
                    textStyle: const TextStyle(
                      color: Colors.black, // Warna teks
                      fontStyle: FontStyle.italic, // Gaya teks miring
                      fontWeight: FontWeight.w400, // Ketebalan teks
                      fontSize: 19, // Ukuran teks
                    ),
                  ),
                ),
                Padding(
                  // Padding di dalam kolom
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    // Widget kolom untuk menyusun elemen secara vertikal
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Susunan elemen mulai dari kiri ke kanan
                    children: [
                      Align(
                        // Aligment untuk mengatur posisi teks ke kanan
                        alignment: Alignment.centerRight, // Aligment ke kanan
                        child: Text(
                          // Teks untuk harga paket medis
                          'Rp ${widget.packagePrice.toString()}', // Harga paket medis
                          style: GoogleFonts.nunito(
                            // Gaya teks menggunakan Google Fonts
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.italic, // Gaya teks miring
                              fontSize: 18, // Ukuran teks
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // Container untuk menampilkan detail paket medis
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          // Dekorasi container
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 0, 0)), // Border
                          borderRadius:
                              BorderRadius.circular(5.0), // Border radius
                        ),
                        child: Text(
                          // Teks untuk detail paket medis
                          widget.packageDetail, // Detail paket medis
                          style: GoogleFonts.nunito(
                            // Gaya teks menggunakan Google Fonts
                            textStyle: const TextStyle(
                              fontSize: 16, // Ukuran teks
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        // Spasi vertikal
                        height: 10,
                      ),
                      Text(
                        // Teks untuk judul daftar prosedur
                        'JENIS - JENIS PROSEDUR', // Judul
                        style: GoogleFonts.nunito(
                          // Gaya teks menggunakan Google Fonts
                          textStyle: const TextStyle(
                            fontSize: 18, // Ukuran teks
                            fontWeight: FontWeight.bold, // Ketebalan teks
                          ),
                        ),
                      ),
                      ListView.builder(
                        // Menampilkan daftar prosedur menggunakan list view
                        shrinkWrap:
                            true, // Widget menggunakan sebanyak mungkin ruang yang tersedia
                        physics:
                            NeverScrollableScrollPhysics(), // Menonaktifkan scrolling di dalam ListView
                        itemCount: _items.length, // Jumlah item
                        itemBuilder: (_, index) {
                          // Membuat item di dalam ListView
                          final item =
                              _items[index]; // Mengambil item dari daftar
                          return Card(
                            // Kartu untuk setiap item
                            elevation: 4, // Elevasi kartu
                            color: Color.fromARGB(255, 255, 255,
                                255), // Warna latar belakang kartu
                            child: ExpansionTile(
                              // Ekspansi tile untuk menampilkan konten yang diperluas
                              iconColor: Color.fromARGB(
                                  255, 0, 0, 0), // Warna ikon collapse/expand
                              collapsedIconColor: Color.fromARGB(
                                  255, 0, 0, 0), // Warna ikon collapse
                              childrenPadding: const EdgeInsets.symmetric(
                                // Padding untuk konten yang diperluas
                                vertical: 10, // Padding vertikal
                                horizontal: 20, // Padding horizontal
                              ),
                              expandedCrossAxisAlignment: CrossAxisAlignment
                                  .end, // Susunan elemen yang diperluas
                              title: Text(
                                // Teks untuk judul item
                                item['title'], // Judul item
                                style: const TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 0, 0), // Warna teks
                                ),
                              ),
                              children: [
                                // Konten yang diperluas
                                Text(
                                  // Teks untuk konten yang diperluas
                                  item['content'], // Konten item
                                  style: const TextStyle(
                                    color: Color.fromARGB(
                                        255, 0, 0, 0), // Warna teks
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        // Spasi vertikal
                        height: 20,
                      ),
                      const Divider(
                        // Garis pemisah
                        color: Colors.black, // Warna garis
                      ),
                      Text(
                        // Teks untuk judul syarat dan ketentuan
                        'SYARAT & KETENTUAN', // Judul
                        style: GoogleFonts.nunito(
                          // Gaya teks menggunakan Google Fonts
                          textStyle: const TextStyle(
                            fontSize: 18, // Ukuran teks
                            fontWeight: FontWeight.bold, // Ketebalan teks
                          ),
                        ),
                      ),
                      Container(
                        // Container untuk menampilkan syarat dan ketentuan
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          // Dekorasi container
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 0, 0)), // Border
                          borderRadius:
                              BorderRadius.circular(5.0), // Border radius
                        ),
                        child: Column(
                          // Widget kolom untuk menyusun elemen secara vertikal
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Susunan elemen mulai dari kiri ke kanan
                          children: [
                            Text(
                              // Teks untuk identitas pasien
                              'Identitas Pasien/Patient identity.', // Judul
                              style: GoogleFonts.nunito(
                                // Gaya teks menggunakan Google Fonts
                                textStyle: const TextStyle(
                                  fontSize: 17, // Ukuran teks
                                  fontStyle:
                                      FontStyle.italic, // Gaya teks miring
                                ),
                              ),
                            ),
                            const ListTile(
                              // List tile untuk elemen syarat dan ketentuan
                              leading: Icon(
                                // Ikon di sebelah kiri list tile
                                Icons.circle, // Ikon bulatan
                                size: 10, // Ukuran ikon
                              ),
                              title: Text(// Teks di dalam list tile
                                  'Membawa kartu identitas (KTP/Paspor /Bring identity card (KTP/Passport'), // Teks
                            ),
                            const ListTile(
                              // List tile untuk elemen syarat dan ketentuan
                              leading: Icon(
                                // Ikon di sebelah kiri list tile
                                Icons.circle, // Ikon bulatan
                                size: 10, // Ukuran ikon
                              ),
                              title: Text(// Teks di dalam list tile
                                  'Mengisi informed consent yang telah disediakan oleh pihak RS (di lokasi Life Care Hospitals) / Fill up informed consent provided by the hospital'), // Teks
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
