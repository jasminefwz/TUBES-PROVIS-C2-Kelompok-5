import 'package:flutter/material.dart'; // Impor paket Flutter
import 'package:google_fonts/google_fonts.dart'; // Impor Google Fonts untuk gaya teks
import '../beranda/beranda.dart';
import '../medcheck/detail_page.dart';

class MyHomePage extends StatefulWidget {
  // Widget Stateful untuk halaman utama
  const MyHomePage({Key? key})
      : super(key: key); // Konstruktor untuk membuat instance MyHomePage

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(); // Membuat state untuk MyHomePage
}

class _MyHomePageState extends State<MyHomePage> {
  // State untuk MyHomePage
  final TextEditingController _textController =
      TextEditingController(); // Controller untuk input pencarian

  final List<Map<String, dynamic>> medicalPackages = [
    {
      "name": "Paket A",
      "description": "Skrinning Jantung",
      "price": 1000000,
      "detail":
          "Skrinning jantung adalah proses pemeriksaan untuk mendeteksi kondisi kesehatan jantung, seperti gangguan irama atau penyempitan pembuluh darah, menggunakan berbagai metode seperti elektrokardiogram (EKG) dan pencitraan jantung. Pemeriksaan ini penting untuk mendeteksi dini masalah jantung dan mencegah risiko penyakit kardiovaskular."
    },
    {
      "name": "Paket B",
      "description": "Skrinning THT",
      "price": 150000,
      "detail":
          "Skrinning THT adalah serangkaian pemeriksaan untuk menilai kesehatan telinga, hidung, dan tenggorokan. Ini mencakup pengecekan pendengaran, pemeriksaan sinus, dan evaluasi amandel serta kondisi lain yang memengaruhi sistem pernapasan atas. Skrinning ini penting untuk mendeteksi dini gangguan seperti infeksi telinga, polip hidung, atau masalah pernapasan yang mungkin memerlukan perawatan lebih lanjut."
    },
    {
      "name": "Paket C",
      "description": "Skrinning Ibu dan Anak",
      "price": 1000000,
      "detail":
          "'Paket ini mencakup berbagai layanan medis untuk ibu dan anak, termasuk pemeriksaan kesehatan rutin, konsultasi dokter, dan vaksinasi. Paket ini dirancang untuk memastikan kesehatan dan kesejahteraan ibu dan anak.'"
    },
    {
      "name": "Paket D",
      "description": "Skrinning Umum",
      "price": 990000,
      "detail":
          "Skrinning umum adalah rangkaian tes medis yang dirancang untuk mendeteksi secara dini berbagai kondisi kesehatan umum, termasuk tekanan darah, kadar gula darah, dan fungsi organ tubuh. Ini membantu dalam pemantauan kesehatan secara menyeluruh dan dapat membantu dalam pencegahan penyakit serius dengan intervensi yang tepat waktu."
    },
    {
      "name": "Imunisasi",
      "description": "Vaksin suntik dan oral kepada batita",
      "price": 500000,
      "detail":
          "Skrinning imunisasi melibatkan pemeriksaan status imunisasi seseorang untuk memastikan bahwa mereka telah menerima vaksinasi yang diperlukan sesuai dengan jadwal yang direkomendasikan. Tujuannya adalah untuk melindungi individu dari penyakit menular dan mengurangi risiko penyebaran infeksi di masyarakat secara keseluruhan."
    },
  ];

  List<Map<String, dynamic>> _foundpaket =
      []; // Daftar paket medis yang ditemukan

  @override
  initState() {
    // Inisialisasi state
    _foundpaket =
        medicalPackages; // Set daftar paket medis yang ditemukan sama dengan daftar paket medis awal
    super.initState(); // Panggil initState dari superclass
  }

  void _runFilter(String enteredKeyword) {
    // Fungsi untuk melakukan filter pada daftar paket medis
    List<Map<String, dynamic>> results = []; // Daftar hasil pencarian
    if (enteredKeyword.isEmpty) {
      // Jika input pencarian kosong
      results = medicalPackages; // Tampilkan semua paket medis
    } else {
      results =
          medicalPackages // Jika ada input pencarian, filter paket medis sesuai dengan keyword
              .where((paket) => paket["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();
    }

    setState(() {
      // Set state dengan daftar paket medis yang telah difilter
      _foundpaket = results;
    });
  }

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
            onPressed: () { // Aksi saat tombol ditekan
              // Mengganti halaman saat ini dengan BerandaPage dan menghapus semua halaman di atasnya dalam tumpukan navigasi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BerandaPage()), // Mengarahkan ke BerandaPage
                (route) => false, // Menghapus semua halaman di atasnya
              );
            },
        ),
        toolbarHeight: 87, // Tinggi toolbar
      ),
      body: SingleChildScrollView(
        // Isi halaman, bisa di-scroll
        child: Padding(
          // Padding di sekitar isi halaman
          padding: const EdgeInsets.all(5.0),
          child: Column(
            // Widget kolom untuk menyusun elemen secara vertikal
            crossAxisAlignment: CrossAxisAlignment
                .start, // Susunan elemen mulai dari kiri ke kanan
            children: [
              Text(
                // Teks judul halaman
                'Medical Check-Up', // Judul halaman
                style: GoogleFonts.nunito(
                    // Gaya teks menggunakan Google Fonts
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Ketebalan teks
                  wordSpacing: 2, // Spasi antar kata
                  fontSize: 25, // Ukuran teks
                )),
              ),
              const SizedBox(height: 10), // Spasi vertikal
              Container(
                // Container untuk input pencarian
                padding: const EdgeInsets.symmetric(
                    horizontal: 10), // Padding horizontal
                decoration: BoxDecoration(
                  // Dekorasi container
                  color: const Color.fromARGB(
                      255, 206, 231, 253), // Warna latar belakang
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                child: TextField(
                  // Input teks untuk pencarian
                  controller: _textController, // Controller untuk input teks
                  onChanged:
                      _runFilter, // Fungsi yang dipanggil saat teks berubah
                  decoration: const InputDecoration(
                    // Dekorasi input teks
                    hintText: 'Cari Layanan Kesehatan', // Hint teks
                    border: InputBorder.none, // Tidak ada border
                    suffixIcon: Icon(Icons.search), // Ikon pencarian
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spasi vertikal
              GridView.builder(
                  // Menampilkan daftar paket medis menggunakan grid view
                  physics:
                      const NeverScrollableScrollPhysics(), // Menonaktifkan scrolling di dalam GridView
                  shrinkWrap:
                      true, // Widget menggunakan sebanyak mungkin ruang yang tersedia
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // Menentukan susunan grid
                    crossAxisCount: 2, // Jumlah item per baris
                    crossAxisSpacing: 8, // Spasi antar item di horizontal
                    mainAxisSpacing: 8, // Spasi antar item di vertikal
                  ),
                  itemCount:
                      _foundpaket.length, // Jumlah item yang akan ditampilkan
                  itemBuilder: (context, index) {
                    // Membangun setiap item pada grid view
                    final package = _foundpaket[
                        index]; // Mendapatkan paket medis pada indeks tertentu
                    return Card(
                      // Kartu untuk menampilkan informasi paket medis
                      elevation: 2, // Elevasi kartu
                      child: Padding(
                        // Padding di dalam kartu
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // Widget kolom untuk menyusun elemen secara vertikal
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Susunan elemen mulai dari kiri ke kanan
                          children: [
                            Text(
                              // Teks untuk nama paket medis
                              package["name"].toString(), // Nama paket medis
                              style: GoogleFonts.nunito(
                                  // Gaya teks menggunakan Google Fonts
                                  textStyle: const TextStyle(
                                      fontWeight:
                                          FontWeight.bold, // Ketebalan teks
                                      fontSize: 23)), // Ukuran teks
                            ),
                            const Divider(), // Garis pemisah
                            Text(
                              // Teks untuk deskripsi paket medis
                              package["description"]
                                  .toString(), // Deskripsi paket medis
                              style: GoogleFonts.nunito(
                                  // Gaya teks menggunakan Google Fonts
                                  textStyle: const TextStyle(
                                fontSize: 16, // Ukuran teks
                                fontStyle: FontStyle.italic, // Gaya teks miring
                              )),
                            ),
                            const Spacer(), // Spacer untuk fleksibilitas layout
                            Column(
                              // Widget kolom untuk menyusun elemen secara vertikal
                              crossAxisAlignment: CrossAxisAlignment
                                  .stretch, // Susunan elemen mulai dari kiri ke kanan
                              children: [
                                Align(
                                  // Aligment untuk mengatur posisi teks ke kanan
                                  alignment: Alignment
                                      .centerRight, // Aligment ke kanan
                                  child: Text(
                                    // Teks untuk harga paket medis
                                    'Rp ${package["price"].toString()}', // Harga paket medis
                                    style: GoogleFonts.nunito(
                                        // Gaya teks menggunakan Google Fonts
                                        textStyle: const TextStyle(
                                      fontWeight:
                                          FontWeight.bold, // Ketebalan teks
                                      fontSize: 18, // Ukuran teks
                                    )),
                                  ),
                                ),
                                const SizedBox(height: 5), // Spasi vertikal
                                ElevatedButton(
                                  // Tombol untuk melihat detail paket medis
                                  onPressed: () {
                                    // Navigasi ke halaman detail paket medis
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          packageName: package["name"]
                                              .toString(), // Nama paket medis
                                          packageDescription: package[
                                                  "description"]
                                              .toString(), // Deskripsi paket medis
                                          packagePrice: package["price"]
                                              .toString(), // Harga paket medis
                                          packageDetail: package["detail"]
                                              .toString(), // Detail paket medis
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      // Gaya tombol
                                      backgroundColor: const Color.fromARGB(
                                          255,
                                          206,
                                          231,
                                          253)), // Warna latar belakang tombol
                                  child: Text(
                                    // Teks pada tombol
                                    'Detail', // Teks untuk tombol
                                    style: GoogleFonts.nunito(
                                        // Gaya teks menggunakan Google Fonts
                                        textStyle: const TextStyle(
                                      color: Colors.black, // Warna teks
                                      fontStyle:
                                          FontStyle.italic, // Gaya teks miring
                                      fontWeight:
                                          FontWeight.w400, // Ketebalan teks
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
