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

  Future<Map<String, dynamic>> getWikiPageContent(String title) {
    Dio dio = new Dio();
    var data = homeRepository.searchContent(dio, title);
    return data;
  }

  void result(String teste) {
    print(teste);
  }

  void searchByThisDay(String title) {
    getTitle(title).then((data) {
      if (data.length > 0) {
        var formatedTitle = formatSuggestionTitle(data);
        getWikiPageContent(formatedTitle).then((data) {
          String facts = extractFacts(data);
          List<String> nameList = extractNames(facts);
          getImageNameList(nameList);
          loadText(facts);
        });
      }
    }, onError: (e) {
      print(e);
    });
  }

  List<String> extractNames(String facts) {
    //var iReg = RegExp(
    //r'([A-Z][a-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]+)[ ]*([A-Z][a-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]+)');

    var iReg = RegExp(
        r'([A-Z][a-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]+)[ ]*([A-Z][a-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]+)[ ]*(([A-Z][a-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]+)[ ]*)*');

    return iReg.allMatches(facts).map((m) => m.group(0)).toList();
  }

  void getImageNameList(List<String> nameList) {
    Dio dio = new Dio();
    nameList.map((name) => {name = name.replaceAll(new RegExp(r'\s'), '_'));
    print(nameList);

    //homeRepository.searchImageName(dio, nameList[0]);
    //print('teste');
  }

  String formatSuggestionTitle(var data) {
    return data[1][0].toString().replaceAll(new RegExp(r'\s'), '_');
  }

  String extractFacts(var data) {
    var unformattedText =
        data["query"]["pages"].values.toList()[0]["revisions"][0]["*"];

    var formatted = unformattedText
        .toString()
        .replaceAll(RegExp(r'\[+|\]+|{+|}+'), '')
        .split(new RegExp(r'\*\s'));
    formatted.removeAt(0);
    final iReg = RegExp(r'(\d){4} — (.)+');

    var reduced = formatted.reduce((t, e) => t + e);
    return iReg
        .allMatches(reduced)
        .map((m) => m.group(0))
        .toList()
        .reduce((t, e) => '$t\n$e');
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
