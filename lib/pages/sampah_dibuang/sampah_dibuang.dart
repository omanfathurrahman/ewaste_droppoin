import 'package:ewaste_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SampahDibuangPage extends StatefulWidget {
  const SampahDibuangPage({Key? key}) : super(key: key);

  @override
  _SampahDibuangPageState createState() => _SampahDibuangPageState();
}

class _SampahDibuangPageState extends State<SampahDibuangPage> {
  var sampahDibuang = supabase.from('sampah_dibuang').select('''
    id,
    status_dibuang
    ''').eq('status_dibuang', "Belum diserahkan");

  Future<void> _konfirmasi(num id) async {
    await supabase
        .from('sampah_dibuang')
        .update({'status_dibuang': 'Sudah diserahkan'}).eq('id', id);

    setState(() {
      sampahDibuang = supabase.from('sampah_dibuang').select('''
        id,
        status_dibuang
        ''').eq('status_dibuang', "Belum diserahkan");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: sampahDibuang,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data as List;
                    return Column(
                      children: data
                          .map((itemSampahDibuang) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Id: ${itemSampahDibuang['id'].toString()}"),
                                          const Text("Sampah belum diterima"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange[500]),
                                              onPressed: () {
                                                context.go(
                                                    '/detailSampahDibuang/${itemSampahDibuang['id']}');
                                              },
                                              child: const Text('detail')),
                                          const SizedBox(height: 4),
                                          ElevatedButton(
                                            onPressed: () {
                                              _konfirmasi(
                                                  itemSampahDibuang['id']);
                                            },
                                            child: const Text("selesai"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
