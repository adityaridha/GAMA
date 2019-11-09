class SortTender {
  List<dynamic> sortByValue(List<dynamic> listTender) {
    void swap(List list, int i) {
      Map temp = list[i];
      list[i] = list[i + 1];
      list[i + 1] = temp;
    }

    int n = listTender.length ?? 0;
    int i, step;
    for (step = 0; step < n; step++) {
      for (i = 0; i < n - step - 1; i++) {
        var data_i = listTender[i]["pagu"];
        var data_i_1 = listTender[i + 1]["pagu"];

        double real_data_i;
        double real_data_i_1;

        if (data_i.split(" ")[1] == "M") {
          String temp = data_i.split(" ")[0];
          real_data_i = double.parse(temp.replaceAll(",", ".")) * 1000;
        } else {
          String temp = data_i.split(" ")[0];
          real_data_i = double.parse(temp.replaceAll(",", "."));
        }

        if (data_i_1.split(" ")[1] == "M") {
          String temp = data_i_1.split(" ")[0];
          real_data_i_1 = double.parse(temp.replaceAll(",", ".")) * 1000;
        } else {
          String temp = data_i_1.split(" ")[0];
          real_data_i_1 = double.parse(temp.replaceAll(",", "."));
        }

        if (real_data_i_1 > real_data_i) {
          swap(listTender, i);
        }
      }
    }

    return listTender;
  }
}
