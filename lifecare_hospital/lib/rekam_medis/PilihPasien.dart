import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; //import untuk font
import '../beranda/beranda.dart';
import '../rekam_medis/RekamMedis.dart';

//membuat kelas PilihPasien yang merupakan StatefulWidget
class PilihPasien extends StatefulWidget {
  //override method createState untuk membuat objek dari kelas _PilihPasien
  @override
  _PilihPasien createState() => _PilihPasien();
}

//membuat kelas Patient untuk merepresentasikan data pasien
class Patient {
  final String patientNo; //no pasien
  final String name; //nama pasien
  final String dob; //tgl lahir pasien
  final String gender; //gender pasien
  final String dokter; //dokter
  final String spesialis; //spesialis
  final String berat_badan; //berat badan pasien
  final String tekanan_darah; //tekanan darah pasien
  final String date; //tanggal upload rekam medis
  final String time; //waktu upload rekam medis
  final String nominal; //nominal pembayaran
  final String diagnosisPdfPath; //hasil diagnosa
  final String resepPdfPath; //resep obat

  //konstruktor untuk inisialisasi data pasien
  Patient(
      {required this.patientNo,
      required this.name,
      required this.dob,
      required this.gender,
      required this.dokter,
      required this.spesialis,
      required this.berat_badan,
      required this.tekanan_darah,
      required this.date,
      required this.time,
      required this.nominal,
      required this.diagnosisPdfPath,
      required this.resepPdfPath});
}

//membuat kelas _PilihPasien yang merupakan State dari PilihPasien
class _PilihPasien extends State<PilihPasien> {
  //buat list untuk menyimpan data pasien
  List<Patient> patients = [
    Patient(
        patientNo: '3217480898761234',
        name: 'Ratu Syahirah',
        dob: '28 Feb 2004',
        gender: 'Perempuan',
        dokter: 'Dr. Jeon Wonwoo',
        spesialis: 'Dokter Umum',
        berat_badan: '53 kg',
        tekanan_darah: '112/72',
        date: '15/02/2024',
        time: '16.31',
        nominal: 'Rp 370.500',
        diagnosisPdfPath: 'assets/images/hasil_diagnosa_ratu.pdf',
        resepPdfPath: 'assets/images/resep_obat_ratu.pdf'),
    Patient(
        patientNo: '3217480898768912',
        name: 'Marvel Ravindra',
        dob: '24 Des 2003',
        gender: 'Laki-laki',
        dokter: 'Dr. Park Sooyoung',
        spesialis: 'Dokter THT',
        berat_badan: '20 kg',
        tekanan_darah: '100/50',
        date: '11/05/2024',
        time: '10.00',
        nominal: 'Rp 5.000.000',
        diagnosisPdfPath: 'assets/images/hasil_diagnosa_marvel.pdf',
        resepPdfPath: 'assets/images/resep_obat_marvel.pdf'),
    Patient(
        patientNo: '3217480898765671',
        name: 'Rifanny Lysara',
        dob: '29 Nov 2004',
        gender: 'Perempuan',
        dokter: 'Dr. Jung Hoseok',
        spesialis: 'Dokter OBGYN',
        berat_badan: '55 kg',
        tekanan_darah: '115/65',
        date: '07/07/2024',
        time: '15.00',
        nominal: 'Rp 1.000.000',
        diagnosisPdfPath: 'assets/images/hasil_diagnosa_rifanny.pdf',
        resepPdfPath: 'assets/images/resep_obat_rifanny.pdf'),
    Patient(
        patientNo: '567890123',
        name: 'Michael Smith',
        dob: '10 Sep 1975',
        gender: 'Laki-laki',
        dokter: 'Dr. Kim Taehyung',
        spesialis: 'Dokter Kulit',
        berat_badan: '60 kg',
        tekanan_darah: '130/80',
        date: '09/10/2023',
        time: '14.50',
        nominal: 'Rp 200.000',
        diagnosisPdfPath: 'assets/images/hasil_diagnosa_michael.pdf',
        resepPdfPath: 'assets/images/resep_obat_michael.pdf'),
    Patient(
        patientNo: '456789012',
        name: 'Emily Johnson',
        dob: '05 Apr 2000',
        gender: 'Perempuan',
        dokter: 'Dr. Lee Minho',
        spesialis: 'Dokter Mata',
        berat_badan: '40 kg',
        tekanan_darah: '120/90',
        date: '12/03/2022',
        time: '17.30',
        nominal: 'Rp 90.000',
        diagnosisPdfPath: 'assets/images/hasil_diagnosa_emily.pdf',
        resepPdfPath: 'assets/images/resep_obat_emily.pdf'),
  ];

  //method build untuk membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //membuat appbar pilih pasien
      appBar: AppBar(
        //background appbar
        backgroundColor: Color(0xFF0068D7),
        //judul appbar
        title: Text(
          'PILIH PASIEN',
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
          //menggunakan icon close
          icon: Icon(Icons.close),
          color: Colors.white,
            onPressed: () { // Aksi saat tombol ditekan
              // Mengganti halaman saat ini dengan BerandaPage dan menghapus semua halaman di atasnya dalam tumpukan navigasi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BerandaPage()), // Mengarahkan ke BerandaPage
                (route) => false, // Menghapus semua halaman di atasnya
              );
            },
        ),
        toolbarHeight: 87, //tinggi app bar
      ),
      body: SingleChildScrollView(
        //widget scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 0,
            ),

            //data pasien menggunakan ListView.builder
            SizedBox(height: 3),
            ListView.builder(
              shrinkWrap:
                  true, //agar ListView hanya mengonsumsi ruang yang diperlukan
              physics: NeverScrollableScrollPhysics(),
              itemCount: patients.length, //jumlah item dalam ListView
              //membangun item dalam ListView
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        //implementasi ketika container diklik
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RekamMedis(
                                  selectedPatient: patients[
                                      index])), //mengarahkan ke halaman rekam medis sesuai dengan pasien yang telah dipilih
                        );
                      },
                      //container untuk menampilkan detail pasien
                      child: Container(
                        width: 350,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFCEE7FD),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //nampilin profil
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 38, left: 12, right: 12),
                              child: Image.asset(
                                'assets/images/profil.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                            //nampilin line
                            Container(
                              height: 137,
                              width: 1,
                              color: Colors.black,
                            ),
                            //nampilin data pasien
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //baris untuk no pasien
                                    Row(
                                      children: [
                                        Text(
                                          'No. Pasien : ${patients[index].patientNo}',
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
                                    SizedBox(height: 8),
                                    //baris untuk nama pasien
                                    Row(
                                      children: [
                                        Text(
                                          'Nama Pasien    : ${patients[index].name}',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    //baris untuk tanggal lahir
                                    Row(
                                      children: [
                                        Text(
                                          'Tanggal Lahir   : ${patients[index].dob}',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    //baris untuk jenis kelamin
                                    Row(
                                      children: [
                                        Text(
                                          'Jenis Kelamin  : ${patients[index].gender}',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            //batas di akhir
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
