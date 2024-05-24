import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; //import untuk pdf
import 'package:google_fonts/google_fonts.dart'; //import untuk font
import '../janji_temu/janji_temu.dart'; //import class janji temu

//membuat kelas RiwayatDaftar yang merupakan StatefulWidget
class RiwayatDaftar extends StatefulWidget {
  //override method createState untuk membuat objek dari kelas _RiwayatDaftar
  @override
  _RiwayatDaftar createState() => _RiwayatDaftar();
}

//membuat kelas Patient untuk merepresentasikan data pasien
class Patient {
  final String patientNo; //no pasien
  final String name; //nama pasien
  final String dob; //tgl lahir pasien
  final String gender; //gender pasien
  final String dokter; //dokter
  final String spesialis; //spesialis
  final String no_invoice; //berat badan pasien
  final String no_antrian; //tekanan darah pasien
  final String date; //tanggal upload rekam medis
  final String time; //waktu upload rekam medis
  final String rdok; //ruang dokter
  final String checkinPdfPath; //check in file

  //konstruktor untuk inisialisasi data pasien
  Patient(
      {required this.patientNo,
      required this.name,
      required this.dob,
      required this.gender,
      required this.dokter,
      required this.spesialis,
      required this.no_invoice,
      required this.no_antrian,
      required this.date,
      required this.time,
      required this.rdok,
      required this.checkinPdfPath});
}

//deklarasi variabel _searchController sebagai TextEditingController
TextEditingController _searchController = TextEditingController();

//membuat kelas _RekamMedis yang merupakan State dari RekamMedis
class _RiwayatDaftar extends State<RiwayatDaftar> {
  //buat list untuk menyimpan data pasien
  List<Patient> patients = [
    Patient(
        patientNo: '3217480898761234',
        name: 'Ratu Syahirah',
        dob: '28 Feb 2004',
        gender: 'Perempuan',
        dokter: 'Dr. Jeon Wonwoo',
        spesialis: 'Dokter Umum',
        no_invoice: 'INV240215002',
        no_antrian: '2',
        date: 'Kamis, 15 Feb 2024',
        time: '16.00',
        rdok: 'Lt 2 ruang A',
        checkinPdfPath: 'assets/images/save_file_ratu.pdf'),
    Patient(
        patientNo: '3217480898768912',
        name: 'Marvel Ravindra',
        dob: '24 Des 2003',
        gender: 'Laki-laki',
        dokter: 'Dr. Park Sooyoung',
        spesialis: 'Dokter THT',
        no_invoice: 'INV240311010',
        no_antrian: '10',
        date: 'Jumat, 11 Mei 2024',
        time: '09.30',
        rdok: 'Lt 5 ruang F',
        checkinPdfPath: 'assets/images/save_file_marvel.pdf'),
    Patient(
        patientNo: '3217480898765671',
        name: 'Rifanny Lysara',
        dob: '29 Nov 2004',
        gender: 'Perempuan',
        dokter: 'Dr. Jung Hoseok',
        spesialis: 'Dokter OBGYN',
        no_invoice: 'INV240707005',
        no_antrian: '5',
        date: 'Rabu, 07 Jul 2024',
        time: '14.30',
        rdok: 'Lt 4 ruang C',
        checkinPdfPath: 'assets/images/save_file_rifanny.pdf'),
  ];

  //tambahkan variabel filteredPatients dan inisialisasikan dengan nilai patients
  List<Patient> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk mengawasi perubahan pada TextField pencarian
    _searchController.addListener(_searchPatients);
    //inisialisasi filteredPatients dengan nilai patients saat inisialisasi state
    filteredPatients = patients;
  }

  //fungsi untuk memfilter pasien berdasarkan kata kunci pencarian
  void _searchPatients() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      //lakukan filter pada daftar pasien berdasarkan query
      filteredPatients = patients.where((patient) {
        //cocokkan query dengan nama dokter atau spesialis
        return patient.dokter.toLowerCase().contains(query) ||
            patient.spesialis.toLowerCase().contains(query);
      }).toList();
    });
  }

  //method build untuk membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //membuat appbar riwayat pendaftaran
      appBar: AppBar(
        //bg appbar
        backgroundColor: Color(0xFF0068D7),
        //judul appbar
        title: Text(
          'RIWAYAT PENDAFTARAN',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        //untuk menempatkan judul di tengah app bar
        centerTitle: true,
        //tombol di sebelah kiri app bar
        leading: IconButton(
          //menggunakan icon arrow back
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            //aksi ketika arrow back di klik
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      JanjiTemu()), //mengarahkan kembali ke halaman janji temu
            );
          },
        ),
        toolbarHeight: 87,
      ),
      //widget dapat di scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //search
            SizedBox(height: 20),
            Container(
              width: 328,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFFCEE7FD),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        String query = _searchController.text.toLowerCase();
                        setState(() {
                          //lakukan filter pada daftar pasien berdasarkan query
                          filteredPatients = patients.where((patient) {
                            //cocokkan query dengan nama dokter atau spesialis
                            return patient.dokter
                                    .toLowerCase()
                                    .contains(query) ||
                                patient.spesialis.toLowerCase().contains(query);
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari Dokter atau Spesialis',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/search.png',
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),

            //riwayat check in menggunakan ListView.builder
            SizedBox(height: 5),
            ListView.builder(
              shrinkWrap:
                  true, //agar ListView hanya mengonsumsi ruang yang diperlukan
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredPatients.length, //jumlah item dalam ListView
              //membangun item dalam ListView
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        // Implementasi ketika container diklik
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckIn(
                                  selectedPatient: filteredPatients[
                                      index])), //mengarah ke halaman selanjutnya yaitu CheckIn
                        );
                      },
                      //kontainer besar
                      child: Container(
                        width: 328,
                        height: 370,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFCEE7FD),
                        ),
                        child: Column(
                          children: [
                            //kontainer check in
                            Container(
                              width: 328,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF389AFF),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  'CHECK IN',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //data pasien
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nama Pasien',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].name}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'No. Pasien',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].patientNo}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Spesialis',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].spesialis}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Hari, Tanggal',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].date}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'No. Invoice',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].no_invoice}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //allign kanan
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Tanggal Lahir',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].dob}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Jenis Kelamin',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].gender}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Dokter',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].dokter}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Waktu',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].time}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'No. Antrian',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${filteredPatients[index].no_antrian}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CheckIn extends StatefulWidget {
  //parameter selectedPatient
  final Patient selectedPatient;
  CheckIn({required this.selectedPatient});

  @override
  _CheckIn createState() => _CheckIn(selectedPatient: selectedPatient);
}

class _CheckIn extends State<CheckIn> {
  //gunakan selectedPatient untuk menampilkan informasi pasien
  final Patient selectedPatient;
  _CheckIn({required this.selectedPatient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'CHECK IN',
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
          //menggunakan arror back
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RiwayatDaftar()), //mengarah ke halaman selanjutnya yaitu RiwayatDaftar
            );
          },
        ),
        toolbarHeight: 87,
      ),
      //widget bisa scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //save file
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 3),
                  child: Image.asset(
                    'assets/images/savefile.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Implementasi untuk menyimpan file PDF
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PDFPage(selectedPatient.checkinPdfPath),
                      ),
                    );
                  },
                  child: Text(
                    "Simpan File",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),

            //line
            SizedBox(height: 20),
            Container(
              height: 1,
              width: 298,
              color: Colors.black,
            ),

            //data check in
            SizedBox(height: 20),
            Container(
              width: 334,
              height: 335,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. Invoice',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.no_invoice}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Nama Pasien',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.name}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'No. Pasien',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.patientNo}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Spesialis',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.spesialis}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Hari, Tanggal',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.date}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'No. Antrian',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.no_antrian}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Tanggal Lahir',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.dob}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Jenis Kelamin',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.gender}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Dokter',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.dokter}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Waktu',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${selectedPatient.time}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //line
            SizedBox(height: 20),
            Container(
              height: 1,
              width: 298,
              color: Colors.black,
            ),

            //logo rs
            SizedBox(height: 20),
            Image.asset(
              'assets/images/logors.jpg',
              width: 140,
              height: 140,
            ),

            //qr qode
            SizedBox(height: 30),
            Text(
              "Kode Pendaftaran Anda",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            Image.asset(
              'assets/images/qr.jpg',
              width: 115,
              height: 115,
            ),

            //kode pendaftaran
            Container(
              width: 240,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF389AFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "${selectedPatient.dob} - ${selectedPatient.no_invoice}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),

            //line
            SizedBox(height: 20),
            Container(
              height: 1,
              width: 298,
              color: Colors.black,
            ),

            //judul persyaratan tahapan
            SizedBox(height: 20),
            Text(
              'Persyaratan dan Tahapan',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),

            //persyaratan
            SizedBox(height: 20),
            Container(
              width: 334,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Persyaratan',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //no1
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      //isi di expand
                      Expanded(
                        child: Text(
                          "Pasien membawa rekam medis yang terdapat di dalam aplikasi Rumah Sakit Life Care.",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //no2
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2. ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      //isi di expand
                      Expanded(
                        child: Text(
                          "Jangan lupa untuk membawa bukti pendaftaran (QR Code) yang terdapat di dalam aplikasi Rumah Sakit Life Care.",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Jika berkas Anda tidak lengkap, maka Anda tidak dapat dilayani',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //tahapan
            SizedBox(height: 25),
            Container(
              width: 334,
              height: 210,
              child: Stack(
                children: [
                  Positioned(
                    left: 9,
                    top: 0,
                    child: SizedBox(
                      width: 96,
                      height: 35,
                      child: Text(
                        'Tahapan',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //tracking flow
                  Positioned(
                    top: 40,
                    left: 1,
                    child: Container(
                      width: 9,
                      height: 164,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            //container hijau yang tandanya belum melewati tahapan
                            child: Container(
                              width: 9,
                              height: 164,
                              decoration: ShapeDecoration(
                                color: Color(0xFF99E0E0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    //container biru muda yang tandanya sudah melewati tahapan
                                    child: Container(
                                      width: 9,
                                      height: 70,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFCEE7FD),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 9,
                              height: 164,
                              child: Stack(
                                children: [
                                  //seperti tanda ceklisnya diasumsikan dengan lingkaran biru muda
                                  Positioned(
                                    left: 0,
                                    top: 62,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF389AFF),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  //seperti tanda ceklisnya diasumsikan dengan lingkaran biru muda
                                  Positioned(
                                    left: 0,
                                    top: 31,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF389AFF),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  //seperti tanda ceklisnya diasumsikan dengan lingkaran biru muda
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF389AFF),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  //seperti tanda ceklisnya (belum) diasumsikan dengan lingkaran biru tua
                                  Positioned(
                                    left: 0,
                                    top: 155,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF0068D7),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  //seperti tanda ceklisnya (belum) diasumsikan dengan lingkaran biru tua
                                  Positioned(
                                    left: 0,
                                    top: 124,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF0068D7),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  //seperti tanda ceklisnya (belum) diasumsikan dengan lingkaran biru tua
                                  Positioned(
                                    left: 0,
                                    top: 93,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF0068D7),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //text tahapan
                  Positioned(
                    top: 35,
                    left: 23,
                    child: Container(
                      width: 315,
                      height: 177,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SizedBox(
                              //width: 296,
                              height: 22,
                              child: Text(
                                'Silahkan Check-In di Lobby',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 31,
                            child: SizedBox(
                              //width: 296,
                              height: 22,
                              child: Text(
                                'Silahkan ke Nurse Station di Lt 2',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 62,
                            child: SizedBox(
                              //width: 296,
                              height: 22,
                              child: Text(
                                'Silahkan ke ruang dokter di ${selectedPatient.rdok}',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 93,
                            child: SizedBox(
                              //width: 296,
                              height: 22,
                              child: Text(
                                'Anda sedang diperiksa oleh dokter',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 124,
                            child: SizedBox(
                              //width: 296,
                              height: 22,
                              child: Text(
                                'Pembayaran di menu Rekam Medis',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 155,
                            child: SizedBox(
                              //width: 296,
                              height: 22,
                              child: Text(
                                'Pengambilan obat',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //line
            SizedBox(height: 20),
            Container(
              height: 1,
              width: 298,
              color: Colors.black,
            ),

            //tombol batal janji temu
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color(0xFFCEE7FD),
                      title: Text(
                        'Konfirmasi',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      content: Text(
                        'Apakah Anda Yakin akan Membatalkan Janji Temu?',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Kembali
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Kembali',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xFF0068D7), // Ganti warna tombol "Ya, Yakin"
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ya, Yakin
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RiwayatDaftar()), //mengarah ke halaman selanjutnya yaitu RiwayatDaftar
                            );
                          },
                          child: Text(
                            'Ya, Yakin',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
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
                'BATALKAN JANJI TEMU',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0068D7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 85,
                ),
              ),
            ),

            //ketentuan batal janji temu
            SizedBox(height: 20),
            Container(
              width: 334,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penting!',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Pasien dapat membatalkan janji temu maksimal h - 10 jam sebelum jadwal yang telah disepakati. Jika pasien tidak check in 30 menit sebelum batas janji atau dalam arti tidak ada kabar, maka janji temu akan auto cancel.",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2. ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Jika pasien tidak check in 30 menit sebelum batas janji atau dalam arti tidak ada kabar, maka janji temu akan auto cancel.",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class PDFPage extends StatelessWidget {
  final String pdfAssetPath;

  PDFPage(this.pdfAssetPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        centerTitle: true,
        title: Text(
          'CHECK IN',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.white), // Mengatur warna ikon "back" menjadi putih
        toolbarHeight: 87, //tinggi app bar
      ),
      body: SfPdfViewer.asset(pdfAssetPath),
    );
  }
}
