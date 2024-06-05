import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; //import untuk pdf
import 'package:google_fonts/google_fonts.dart'; //import untuk font
import '../rekam_medis/pembayaran.dart';
import '../rekam_medis/PilihPasien.dart';

//membuat kelas RekamMedis yang merupakan StatefulWidget, hasil navigasi dari PilihPasien
class RekamMedis extends StatefulWidget {
  //parameter selectedPatient
  final Patient selectedPatient;
  RekamMedis({required this.selectedPatient});

  @override
  _RekamMedis createState() => _RekamMedis(selectedPatient: selectedPatient);
}

//membuat kelas _RekamMedis yang merupakan State dari RekamMedis
class _RekamMedis extends State<RekamMedis> {
  //gunakan selectedPatient untuk menampilkan informasi pasien
  final Patient selectedPatient;
  _RekamMedis({required this.selectedPatient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        title: Text(
          'REKAM MEDIS',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          //menggunakan icon arrow back
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PilihPasien()), //mengarah kembali ke halaman PilihPasien
            );
          },
        ),
        toolbarHeight: 87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 0,
            ),

            //informasi pasien
            SizedBox(height: 10),
            Container(
              width: 345,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFCEE7FD),
              ),
              child: Column(
                children: [
                  Container(
                    width: 345,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF0068D7),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        'Informasi Pasien',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No. Pasien       : ${selectedPatient.patientNo}',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'Nama Pasien   : ${selectedPatient.name}',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'Tanggal Lahir  : ${selectedPatient.dob}',
                              style: GoogleFonts.nunito(
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

            //hasil rekam medis
            SizedBox(height: 20),
            Container(
              width: 345,
              height: 365,
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Color(0xFFCEE7FD),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //baris untuk spesialis dan dokter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Spesialis  : ${selectedPatient.spesialis}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              'Dokter       : ${selectedPatient.dokter}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  //baris untuk berat badan dan tekanan darah
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Berat Badan',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              '${selectedPatient.berat_badan}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //di expand tekanan darahnya
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Tekanan Darah',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              '${selectedPatient.tekanan_darah}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //hasil diagnosa
                  TextButton(
                    onPressed: () {
                      // Aksi ketika diagnosa diklik  mengarah ke file pdf
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFPage(
                              selectedPatient.diagnosisPdfPath,
                              'HASIL DIAGNOSA'),
                        ),
                      );
                    },
                    child: Text(
                      'Hasil Diagnosa',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  //resep obat
                  TextButton(
                    onPressed: () {
                      // Aksi ketika resep obat diklik mengarah ke file pdf
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFPage(
                              selectedPatient.resepPdfPath, 'RESEP OBAT'),
                        ),
                      );
                    },
                    child: Text(
                      'Resep Obat',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  //baris untuk status pembayaran dan nominal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //memakai container
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF389AFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Status Pembayaran',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //tombol untuk pembayaran
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi ke halaman pembayaran
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PilihPembayaran(
                                selectedPatient:
                                    selectedPatient)), //mengarahkan kembali ke halaman janji temu
                      );
                    },
                    child: Text(
                      'BAYAR',
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
                        horizontal:
                            130, // Atur padding horizontal sesuai kebutuhan
                      ),
                      // Tambahkan minWidth untuk menentukan lebar minimum tombol
                      minimumSize: Size(40, 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFPage extends StatelessWidget {
  final String pdfAssetPath;
  final String title;

  PDFPage(this.pdfAssetPath, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0068D7),
        centerTitle: true,
        title: Text(
          title,
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
