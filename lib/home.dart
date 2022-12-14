import 'package:flutter/material.dart';
import 'data_source.dart';
import 'detail_page1.dart';
import 'matches_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piala Dunia 2022"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future:
          ListMatchesSource.instance.loadMatches(),

          //cek apakah api bisa terhubung atau tidak
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              // debugPrint(snapshot.data);
              return _buildErrorSection(); //kalau eror akan menampilkan ke sini
            }
            if (snapshot.hasData) {
              return _buildSuccessSection(snapshot.data); //kalau sukses menuji sini
            }
            return _buildLoadingSection(); //kalau data sedang login menapilkan ini
          },
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(List<dynamic> data) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              MatchesModel matchesModel = MatchesModel.fromJson(data[index]);
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: ((context) {
                      return DetailPage(id: matchesModel.id.toString(),); //kalau di klik masuk ke detailpage.dart
                    })
                )),
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          //untuk menapilkan bendera hometeam berdasarkan namanya
                          Image.network("https://countryflagsapi.com/png/${matchesModel.homeTeam?.name}",width: 150,height: 150,),
                          //untuk menampilkan nama team (hometeam)
                          Text("${matchesModel.homeTeam?.name}"),
                        ],
                      ),
                      // Image.network("https://countryflagsapi.com/png/Qatar",width: 120,),
                      SizedBox(width: 20,),
                      //untuk jumlah goal
                      Text("${matchesModel.homeTeam?.goals}"),
                      SizedBox(width: 20,),
                      Text("-"),
                      SizedBox(width: 20,),
                      //jumlah goal lawan
                      Text("${matchesModel.awayTeam?.goals}"),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          //menampilkan bendera awayteam berdasarkan namanya
                          Image.network("https://countryflagsapi.com/png/${matchesModel.awayTeam?.name}",width: 150,height: 150,),
                          Text("${matchesModel.awayTeam?.name}"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}