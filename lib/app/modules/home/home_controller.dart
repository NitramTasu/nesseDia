import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nesse_dia/app/modules/home/home_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  @observable
  int value = 0;

  @observable
  String text = '';

  HomeRepository homeRepository = new HomeRepository();

  void requestGet() {
    Dio dio = new Dio();
    homeRepository.fetchPost(dio).then(print);
  }

  Future<List<dynamic>> getTitle(String search) {
    Dio dio = new Dio();
    var titleResp = homeRepository.searchTitle(dio, search);

    return titleResp;
  }

  Future<Map<String, dynamic>> getContent(String title) {
    Dio dio = new Dio();
    var data = homeRepository.searchContent(dio, title);
    return data;
  }

  void result(String teste) {
    print(teste);
  }

  String searchByThisDay(String title) {
    var titleResp = getTitle("25 de janeiro");
    titleResp.then((data) {
      if (data.length > 0) {
        var formatedTitle =
            data[1][0].toString().replaceAll(new RegExp(r'\s'), '_');
        var resp = getContent(formatedTitle);
        resp.then((data) {
          var unformattedText =
              data["query"]["pages"]["10686"]["revisions"][0]["*"];
          var splited = unformattedText
              .toString()
              .replaceAll(RegExp(r'\['), '')
              .split(new RegExp(r'\*\s'));
          loadText(unformattedText);
        });
      }
    }, onError: (e) {
      print(e);
    });
  }

  @action
  void increment() {
    value++;
  }

  @action
  void loadText(String newText) {
    text = newText;
  }
}
