import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../beranda/beranda.dart';
import '../riwayat_pendaftaran/RiwayatDaftar.dart';

// Kelas untuk menampilkan filter data
class FilterData {
  final List<String> spesialisasi; // List untuk menyimpan spesialisasi dokter
  final List<String> hari; // List untuk menyimpan hari praktek dokter
  final List<String> waktu; // List untuk menyimpan waktu praktek dokter

  FilterData({
    required this.spesialisasi,
    required this.hari,
    required this.waktu,
  });

  int totalFilters() {
    return spesialisasi.length +
        hari.length +
        waktu.length; // Menghitung total filter yang dipilih
  }
}

// Kelas untuk menampilkan halaman Buat Janji Temu
class JanjiTemu extends StatefulWidget {
  @override
  _JanjiTemuState createState() => _JanjiTemuState();
}

class _JanjiTemuState extends State<JanjiTemu> {
  FilterData? _filterData; // Data filter yang dipilih
  List<Map<String, dynamic>> filteredDokterData =
      List.from(dokterData); // Data dokter yang telah disaring

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'BUAT JANJI TEMU',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true, // Judul ditengah app bar
        leading: IconButton(
          icon: Image.asset(
            'images/cancel.png',
            width: 15,
            height: 15,
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
        toolbarHeight: 87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Cari Dokter dan Buat Janji Temu',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                // Saat nilai TextField berubah, lakukan penyaringan data
                setState(() {
                  filteredDokterData = dokterData.where((dokter) {
                    return dokter['nama']
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari nama dokter',
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFCEE7FD),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16), // Sesuaikan dengan kebutuhan Anda
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 8,
                    height: 8,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Tampilkan halaman FilterPage dan terima hasil filter
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                  if (result != null) {
                    setState(() {
                      _filterData = result;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFFCEE7FD), // Ganti warna tombol menjadi biru muda
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/filter.png',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              if (_filterData != null) ...[
                SizedBox(height: 5),
                Text(
                  '[${_filterData!.totalFilters()}]', // Tampilkan total filter yang dipilih
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDokterData.length,
              itemBuilder: (context, index) {
                final dokter = filteredDokterData[index];
                return Card(
                  color: Color(0xFFCEE7FD),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(dokter['avatar']),
                        ),
                        title: Text(
                          dokter['nama'],
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              dokter['spesialis'],
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Divider(),
                            Text(
                              'Ketersediaan hari: ${dokter['jadwalRawatJalan'].map((jadwal) => jadwal['hari']).join(', ')}',
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoctorProfilePage(dokter: dokter),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF0068D7),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          ),
                        ),
                        child: Text(
                          'Buat Janji',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumberButton(1),
              buildNumberButton(2),
              buildNumberButton(3),
              IconButton(
                icon: Image.asset(
                  'images/arrowRight.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  //Proses pendaftaran
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RiwayatDaftar()), //mengarahkan kembali ke halaman janji temu
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0068D7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 70,
                  ),
                ),
                child: Text(
                  'RIWAYAT PENDAFTARAN',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildNumberButton(int number) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFCEE7FD),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        '$number',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
    );
  }
}

// Kelas untuk menampilkan halaman filter dokter
class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'FILTER',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true, // Judul ditengah app bar
        leading: IconButton(
          icon: Image.asset(
            'images/arrowLeft.png',
            width: 15,
            height: 15,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Aksi ketika tombol panah kembali ditekan
          },
        ),
        toolbarHeight: 87,
      ),
      body: FilterForm(), // Menampilkan form filter
    );
  }
}

class FilterOption extends StatefulWidget {
  final String title; // Judul filter
  final List<String> options; // Opsi filter
  final List<String> selectedOptions; // Opsi yang dipilih
  final ValueChanged<List<String>>
      onChanged; // Metode yang dipanggil ketika opsi berubah

  const FilterOption({
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _FilterOptionState createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  List<String> _selectedOptions = [];

  void _showCheckBoxDialog(
      BuildContext context, String title, List<String> options) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih ' + title), // Judul dialog
          backgroundColor: Color(0xFFCEE7FD), // Warna latar belakang dialog
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((String option) {
                return CheckboxListTile(
                  title: Text(option), // Menampilkan opsi
                  value: _selectedOptions
                      .contains(option), // Menentukan status opsi
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        if (value) {
                          _selectedOptions
                              .add(option); // Menambah opsi yang dipilih
                        } else {
                          _selectedOptions
                              .remove(option); // Menghapus opsi yang dipilih
                        }
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0068D7), // Warna tombol
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.white,
                ),
              ), // Tombol untuk menutup dialog
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          widget.title, // Menampilkan judul filter
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        if (widget.title == 'SPESIALISASI') // Jika filter adalah spesialisasi
          Container(
            width: 400,
            child: DropdownButtonFormField<String>(
              value: _selectedOptions.isNotEmpty ? _selectedOptions[0] : null,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOptions.clear();
                  if (newValue != null) {
                    _selectedOptions.add(newValue);
                  }
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Semua Spesialisasi', // Opsi semua spesialisasi
                  child: Text(
                    'Semua Spesialisasi',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ...widget.options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option, // Opsi spesialisasi lainnya
                    child: Text(option),
                  );
                }).toList(),
              ],
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              iconEnabledColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFCEE7FD), // Warna latar belakang
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // Menghapus border
                ),
              ),
            ),
          ),
        if (widget.title != 'SPESIALISASI') // Jika filter bukan spesialisasi
          InkWell(
            onTap: () {
              _showCheckBoxDialog(context, widget.title,
                  widget.options); // Menampilkan dialog untuk memilih opsi
            },
            child: Container(
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFCEE7FD),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedOptions.isNotEmpty
                      ? _selectedOptions.join(
                          ", ") // Menampilkan opsi yang dipilih sebagai teks
                      : 'Pilih ' +
                          widget
                              .title), // Menampilkan teks default jika tidak ada yang dipilih
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class FilterForm extends StatefulWidget {
  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  List<String> _selectedSpesialisasi = [];
  List<String> _selectedHari = [];
  List<String> _selectedWaktu = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Filter Dokter berdasarkan Beberapa Opsi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: Column(
            children: [
              FilterOption(
                title: 'SPESIALISASI',
                options: [
                  'Dokter Umum',
                  'Jantung',
                  'Dokter Gigi',
                  'OBGYN'
                ], // Opsi spesialisasi
                selectedOptions: _selectedSpesialisasi,
                onChanged: (selectedOptions) {
                  setState(() {
                    _selectedSpesialisasi = selectedOptions;
                  });
                },
              ),
              SizedBox(height: 20),
              FilterOption(
                title: 'HARI',
                options: [
                  'Senin',
                  'Selasa',
                  'Rabu',
                  'Kamis',
                  'Jumat',
                  'Sabtu'
                ], // Opsi hari
                selectedOptions: _selectedHari,
                onChanged: (selectedOptions) {
                  setState(() {
                    _selectedHari = selectedOptions;
                  });
                },
              ),
              SizedBox(height: 20),
              FilterOption(
                title: 'WAKTU',
                options: ['Pagi', 'Siang', 'Malam'], // Opsi waktu
                selectedOptions: _selectedWaktu,
                onChanged: (selectedOptions) {
                  setState(() {
                    _selectedWaktu = selectedOptions;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedSpesialisasi.clear();
                  _selectedHari.clear();
                  _selectedWaktu.clear();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                'RESET', // Tombol untuk mereset pilihan filter
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FilterData filterData = FilterData(
                  spesialisasi: _selectedSpesialisasi,
                  hari: _selectedHari,
                  waktu: _selectedWaktu,
                );
                Navigator.of(context).pop(
                    filterData); // Menutup halaman filter dan mengirimkan data filter
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF0068D7)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                'CARI', // Tombol untuk memulai pencarian berdasarkan filter
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

// List untuk menyimpan data dummy sementara
List<Map<String, dynamic>> dokterData = [
  {
    'nama': 'Dr. Jeon Wonwoo',
    'spesialis': 'Dokter Umum',
    'avatar': 'images/doctor_avatar.jpeg',
    'deskripsi':
        'Dr. Jeon Wonwoo adalah seorang dokter umum dengan pengalaman luas dalam praktik medis.',
    'jadwalRawatJalan': [
      {'hari': 'Senin', 'waktu': '16.00 - 20.00'},
      {'hari': 'Selasa', 'waktu': '09.00 - 12.00'},
      {'hari': 'Rabu', 'waktu': '14.00 - 18.00'},
    ],
  },
  {
    'nama': 'Dr. Jane Smith',
    'spesialis': 'Dokter Gigi',
    'avatar': 'images/profilPutih.png',
    'deskripsi':
        'Dr. Jane Smith adalah seorang dokter gigi yang berpengalaman dalam perawatan gigi dan mulut.',
    'jadwalRawatJalan': [
      {'hari': 'Senin', 'waktu': '08.00 - 12.00'},
      {'hari': 'Rabu', 'waktu': '08.00 - 12.00'},
      {'hari': 'Jumat', 'waktu': '08.00 - 12.00'},
    ],
  },
  {
    'nama': 'Dr. Lee Minho',
    'spesialis': 'Dokter Mata',
    'avatar': 'images/doctor_avatar.jpeg',
    'deskripsi':
        'Dr. Lee Minho adalah seorang dokter mata dengan keahlian dalam diagnosis dan pengobatan penyakit mata.',
    'jadwalRawatJalan': [
      {'hari': 'Selasa', 'waktu': '14.00 - 18.00'},
      {'hari': 'Kamis', 'waktu': '09.00 - 13.00'},
      {'hari': 'Sabtu', 'waktu': '08.00 - 12.00'},
    ],
  },
  {
    'nama': 'Dr. Park Sooyoung',
    'spesialis': 'Dokter THT',
    'avatar': 'images/profilPutih.png',
    'deskripsi':
        'Dr. Park Sooyoung adalah seorang spesialis THT yang berpengalaman dalam perawatan gangguan telinga, hidung, dan tenggorokan.',
    'jadwalRawatJalan': [
      {'hari': 'Senin', 'waktu': '09.00 - 12.00'},
      {'hari': 'Rabu', 'waktu': '13.00 - 17.00'},
      {'hari': 'Jumat', 'waktu': '08.00 - 12.00'},
    ],
  },
  {
    'nama': 'Dr. Kim Taehyung',
    'spesialis': 'Dokter Kulit',
    'avatar': 'images/doctor_avatar.jpeg',
    'deskripsi':
        'Dr. Kim Taehyung adalah seorang dokter kulit yang ahli dalam merawat masalah kulit dan perawatan kecantikan.',
    'jadwalRawatJalan': [
      {'hari': 'Selasa', 'waktu': '10.00 - 14.00'},
      {'hari': 'Kamis', 'waktu': '14.00 - 18.00'},
      {'hari': 'Sabtu', 'waktu': '09.00 - 13.00'},
    ],
  },
  {
    'nama': 'Dr. Jung Hoseok',
    'spesialis': 'Dokter OBGYN',
    'avatar': 'images/profilPutih.png',
    'deskripsi':
        'Dr. Jung Hoseok adalah seorang ahli obstetri dan ginekologi yang berpengalaman dalam perawatan kesehatan wanita.',
    'jadwalRawatJalan': [
      {'hari': 'Senin', 'waktu': '10.00 - 14.00'},
      {'hari': 'Rabu', 'waktu': '09.00 - 12.00'},
      {'hari': 'Jumat', 'waktu': '13.00 - 17.00'},
    ],
  },
];

// Kelas untuk menampilkan profil dokter
class DoctorProfilePage extends StatelessWidget {
  final Map<String, dynamic> dokter;

  DoctorProfilePage({required this.dokter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'PROFIL DOKTER',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true, // Untuk menempatkan judul di tengah app bar
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrowLeft.png',
            width: 15,
            height: 15,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Aksi yang ingin dilakukan saat tombol panah kembali ditekan
          },
        ),
        toolbarHeight: 87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(), // Garis pemisah
          Center(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFFCEE7FD),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage(dokter['avatar']), // Avatar dokter
                  ),
                  SizedBox(width: 20), // Spasi horizontal
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dokter['nama'], // Nama dokter
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dokter['spesialis'], // Spesialisasi dokter
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(), // Garis pemisah
          Center(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFFCEE7FD),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi Dokter', // Judul deskripsi
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20), // Spasi horizontal
                  Text(
                    dokter['deskripsi'], // Deskripsi dokter
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(), // Garis pemisah
          Center(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFFCEE7FD),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/janjiTemu.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 20), // Spasi horizontal
                      Text(
                        'Jadwal Rawat Jalan', // Judul jadwal rawat jalan
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Spasi vertikal
                  Divider(), // Garis pemisah
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dokter['jadwalRawatJalan']
                        .length, // Jumlah jadwal rawat jalan
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(dokter['jadwalRawatJalan'][index]['hari'] ??
                            ''), // Hari rawat jalan
                        subtitle: Text(dokter['jadwalRawatJalan'][index]
                                ['waktu'] ??
                            ''), // Waktu rawat jalan
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(), // Spacer untuk mendorong tombol ke bawah
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PilihJadwalPage()),
                  ); // Navigasi ke halaman pilih jadwal
                },
                child: Text(
                  'BUAT JANJI TEMU', // Teks tombol membuat janji temu
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0068D7), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 70,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Jarak vertikal
        ],
      ),
    );
  }
}

// Kelas untuk halaman pilih jadwal
class PilihJadwalPage extends StatefulWidget {
  @override
  _PilihJadwalPageState createState() => _PilihJadwalPageState();
}

// State dari halaman pilih jadwal
class _PilihJadwalPageState extends State<PilihJadwalPage> {
  DateTime? _selectedDateApp;
  TimeOfDay? _selectedTime;

  // Fungsi untuk memilih waktu
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'PILIH JADWAL',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true, // Untuk menempatkan judul di tengah app bar
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrowLeft.png',
            width: 15,
            height: 15,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Aksi yang ingin dilakukan saat tombol panah kembali ditekan
          },
        ),
        toolbarHeight: 87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tampilkan kalender
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFCEE7FD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary:
                      Color(0xFF0068D7), // Warna untuk tanggal yang dipilih
                ),
              ),
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChanged: (DateTime selectedDate) {
                  setState(() {
                    _selectedDateApp = selectedDate;
                  });
                },
              ),
            ),
          ),

          // Tombol untuk memilih waktu
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFCEE7FD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Container(
                width: 100,
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'Pilih Waktu',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors
                          .blue; // Warna latar belakang saat tombol ditekan
                    }
                    return Color(0xFFCEE7FD); // Warna latar belakang default
                  },
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue), // Warna teks tombol
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets
                      .zero, // Padding nol agar tidak ada padding tambahan
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFCEE7FD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: _selectedDateApp != null && _selectedTime != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Tanggal: ${_selectedDateApp!.day}/${_selectedDateApp!.month}/${_selectedDateApp!.year}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      SizedBox(
                          height:
                              8.0), // Jarak vertikal antara tanggal dan waktu
                      Text(
                        'Waktu: ${_selectedTime!.hour}:${_selectedTime!.minute}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  )
                : SizedBox(), // Widget kosong jika tanggal dan waktu belum dipilih
          ),

          Expanded(
            child: SizedBox(), // Spacer untuk mendorong tombol ke bawah
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_selectedDateApp != null && _selectedTime != null) {
                    // Jika tanggal dan waktu sudah dipilih, lanjutkan ke halaman berikutnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PesanOrangLain()),
                    );
                  } else {
                    // Jika tanggal atau waktu belum dipilih, tampilkan pesan kesalahan
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFFCEE7FD),
                          title: Text(
                            'Error',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                              'Mohon pilih tanggal dan waktu terlebih dahulu.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color(
                                    0xFF0068D7), // Ganti warna tombol "Ya, Yakin"
                              ),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.white // Ubah warna teks
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'PESAN UNTUK DIRI SENDIRI', // Teks tombol pesan untuk diri sendiri
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0068D7), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 60,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Jarak vertikal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_selectedDateApp != null && _selectedTime != null) {
                    // Jika tanggal dan waktu sudah dipilih, lanjutkan ke halaman berikutnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PesanOrangLain()),
                    );
                  } else {
                    // Jika tanggal atau waktu belum dipilih, tampilkan pesan kesalahan
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFFCEE7FD),
                          title: Text(
                            'Error',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                              'Mohon pilih tanggal dan waktu terlebih dahulu.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color(
                                    0xFF0068D7), // Ganti warna tombol "Ya, Yakin"
                              ),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.white // Ubah warna teks
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'PESAN UNTUK ORANG LAIN', // Teks tombol pesan untuk orang lain
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0068D7), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 60,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Jarak vertikal
        ],
      ),
    );
  }
}

// Kelas untuk menampilkan halaman form untuk melakukan pemesanan untuk orang lain
class PesanOrangLain extends StatefulWidget {
  @override
  _PesanOrangLainState createState() => _PesanOrangLainState();
}

class _PesanOrangLainState extends State<PesanOrangLain> {
  final TextEditingController _fullNameController =
      TextEditingController(); // Definisikan controller untuk nama lengkap
  final TextEditingController _nikController =
      TextEditingController(); // Definisikan controller untuk NIK
  final TextEditingController _tempatLahirController = TextEditingController();

  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _namaPemesanController = TextEditingController();
  final TextEditingController _noTelpPemesanController =
      TextEditingController();

  int? _selectedGender;
  final TextEditingController _jenisKelaminController = TextEditingController();

  Future<void> _selectGender(BuildContext context) async {
    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Jenis Kelamin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Laki-laki'),
                onTap: () {
                  Navigator.pop(context, 0);
                },
              ),
              ListTile(
                title: Text('Perempuan'),
                onTap: () {
                  Navigator.pop(context, 1);
                },
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedGender = result;
        _jenisKelaminController.text = _selectedGender == 0
            ? 'Laki-laki'
            : 'Perempuan'; // Set nilai pada controller
      });
    }
  }

  DateTime? _selectedDate;
  final TextEditingController _tglLahirController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _tglLahirController.text =
            picked.toString().split(' ')[0]; // Atur nilai pada controller
      });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'ISI DATA DIRI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrowLeft.png',
            width: 15,
            height: 15,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: 87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Nama Lengkap',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama lengkap Anda',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama lengkap harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'NIK',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _nikController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan NIK Anda',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NIK harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Tempat Lahir',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _tempatLahirController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan tempat lahir Anda',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tempat lahir harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Tanggal Lahir',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _tglLahirController,
                      decoration: InputDecoration(
                        hintText: 'Pilih tanggal lahir Anda',
                        filled: true,
                        fillColor: Color(0xFFCEE7FD),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal lahir harus diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Jenis Kelamin',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value as int?;
                          _jenisKelaminController.text = 'Laki-laki';
                        });
                      },
                      activeColor: Color(
                          0xFF0068D7), // Mengatur warna biru tua saat dipilih
                    ),
                    Text('Laki-laki'),
                    Radio(
                      value: 1,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value as int?;
                          _jenisKelaminController.text = 'Perempuan';
                        });
                      },
                      activeColor: Color(
                          0xFF0068D7), // Mengatur warna biru tua saat dipilih
                    ),
                    Text('Perempuan'),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Alamat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  maxLines: 3,
                  controller: _alamatController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan alamat lengkap Anda',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'No Telepon',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _noTelpController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nomor telepon Anda',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Nama Pemesan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _namaPemesanController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Pemesan',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama pemesan harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'No Telepon Pemesan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _noTelpPemesanController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nomor telepon Pemesan',
                    filled: true,
                    fillColor: Color(0xFFCEE7FD),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataDiriPage(
                            fullName: _fullNameController.text,
                            nik: _nikController.text,
                            tempatLahir: _tempatLahirController.text,
                            tglLahir: _tglLahirController.text,
                            jenisKelamin: _jenisKelaminController.text,
                            alamat: _alamatController.text,
                            noTelp: _noTelpController.text,
                            namaPemesan: _namaPemesanController.text,
                            noTelpPemesan: _noTelpController.text,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFFCEE7FD),
                            title: Text(
                              'Error',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text('Semua data diri harus diisi.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(
                                      0xFF0068D7), // Ganti warna tombol "Ya, Yakin"
                                ),
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Colors.white // Ubah warna teks
                                      ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'SIMPAN',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0068D7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Kelas untuk menampilkan DataDiri
class DataDiriPage extends StatelessWidget {
  final String fullName;
  final String nik;
  final String tempatLahir;
  final String tglLahir;
  final String jenisKelamin;
  final String alamat;
  final String noTelp;
  final String namaPemesan;
  final String noTelpPemesan;

  const DataDiriPage(
      {Key? key,
      required this.fullName,
      required this.nik,
      required this.tempatLahir,
      required this.tglLahir,
      required this.jenisKelamin,
      required this.alamat,
      required this.noTelp,
      required this.namaPemesan,
      required this.noTelpPemesan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'DATA DIRI',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true, // Untuk menempatkan judul di tengah app bar
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrowLeft.png',
            width: 15,
            height: 15,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Aksi yang ingin dilakukan saat tombol panah kembali ditekan
          },
        ),
        toolbarHeight: 87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nama Lengkap',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$fullName',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'NIK',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$nik',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tempat Lahir',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$tempatLahir',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tanggal Lahir',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$tglLahir',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jenis Kelamin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$jenisKelamin',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Alamat',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$alamat',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'No Telepon',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$noTelp',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Nama Pemesan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$namaPemesan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'No Telepon Pemesan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // Menggunakan font Poppins dan membuat teks menjadi tebal
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCEE7FD),
                  border: Border.all(
                      color: Colors
                          .grey), // Tambahkan border seperti TextFormField
                  borderRadius: BorderRadius.circular(
                      5), // Atur border radius sesuai kebutuhan
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Sesuaikan padding
                child: Text(
                  '$noTelpPemesan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color(0xFFCEE7FD),
                        title: Text(
                          'Konfirmasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content:
                            Text('Apakah Anda Yakin akan Membuat Janji Temu?'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              // Kembali
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Kembali',
                              style: TextStyle(
                                  color: Colors.white // Ubah warna teks
                                  ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                  0xFF0068D7), // Ganti warna tombol "Ya, Yakin"
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Proses pendaftaran
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RiwayatDaftar()), //mengarahkan kembali ke halaman janji temu
                              );
                            },
                            child: Text(
                              'Ya, Yakin',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white // Ubah warna teks
                                  ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                  0xFF0068D7), // Ganti warna tombol "Ya, Yakin"
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'PESAN',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0068D7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'FILTER',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true, // Judul ditengah app bar
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrowLeft.png',
            width: 15,
            height: 15,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Aksi ketika tombol panah kembali ditekan
          },
        ),
        toolbarHeight: 87,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(3, (index) {
          return GestureDetector(
            onTap: () {
              // Aksi yang ingin dilakukan saat kotak di tekan (mis. navigasi ke halaman tertentu)
            },
            child: Container(
              margin: EdgeInsets.all(10),
              color: Color(0xFF0068D7),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
