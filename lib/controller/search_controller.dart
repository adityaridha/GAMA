class FilterTender {

  List<Map<String, String>> tender = [
    {
      "id": "2629031",
      "title": "Pelaksana Pengadaan Jaringan Listrik Sekolah",
      "institution": "Pemerintah Daerah Kabupaten Bangka",
      "value": "380 Jt",
      "url": "http://lpse.bangka.go.id/eproc4/lelang/2629031/pengumumanlelang"
    },
    {
      "id": "2571031",
      "title": "Belanja Pengadaan Fiber Optik (DID)",
      "institution": "Pemerintah Daerah Kabupaten Bangka",
      "value": "1 M",
      "url": "http://lpse.bangka.go.id/eproc4/lelang/2571031/pengumumanlelang"
    },
    {
      "id": "2516031",
      "title":
      "Pengembangan jaringan perpipaan SPAM Desa Tiang Tara di Kec. Bakam (DAK REGULER)",
      "institution": "Pemerintah Daerah Kabupaten Bangka",
      "value": "943 Jt",
      "url": "http://lpse.bangka.go.id/eproc4/lelang/2516031/pengumumanlelang"
    },
    {
      "id": "2515031",
      "title":
      "Pengembangan Jaringan Perpipaan SPAM PAMSIMAS Desa Mapur dan desa Pugul di kec.Riau Silip ( DAK PENUGASAN)",
      "institution": "Pemerintah Daerah Kabupaten Bangka",
      "value": "337,7 Jt",
      "url": "http://lpse.bangka.go.id/eproc4/lelang/2515031/pengumumanlelang"
    },
    {
      "id": "2375086",
      "title": "Belanja Modal Pengadaan Konstruksi Jaringan",
      "institution": "Pemerintah Daerah Provinsi Kepulauan Bangka Belitung",
      "value": "3,3 M",
      "url":
      "http://lpse.babelprov.go.id/eproc4/lelang/2375086/pengumumanlelang"
    },
    {
      "id": "1752086",
      "title": "Pengadaan Peralatan Jaringan Komputer",
      "institution": "Pemerintah Daerah Provinsi Kepulauan Bangka Belitung",
      "value": "746 Jt",
      "url":
      "http://lpse.babelprov.go.id/eproc4/lelang/1752086/pengumumanlelang"
    },
    {
      "id": "1419086",
      "title": "Pembangunan Jaringan Kabel Optik",
      "institution": "Pemerintah Daerah Provinsi Kepulauan Bangka Belitung",
      "value": "922,5 Jt",
      "url":
      "http://lpse.babelprov.go.id/eproc4/lelang/1419086/pengumumanlelang"
    },
    {
      "id": "2513139",
      "title":
      "Belanja Modal Pengadaan Peralatan Jaringan Fiber Optik dari Kegiatan Pembangunan dan Pengembangan Infrastruktur E-Government",
      "institution": "Pemerintah Daerah Kabupaten Bangka Tengah",
      "value": "860 Jt",
      "url":
      "http://lpse.bangkatengahkab.go.id/eproc4/lelang/2513139/pengumumanlelang"
    },
    {
      "id": "2305139",
      "title": "Pengadaan Jaring Ikan (DAK)",
      "institution": "Pemerintah Daerah Kabupaten Bangka Tengah",
      "value": "391,9 Jt",
      "url":
      "http://lpse.bangkatengahkab.go.id/eproc4/lelang/2305139/pengumumanlelang"
    },
    {
      "id": "1474369",
      "title": "Pengadaan Video Wall dan Slot Card Output Processor",
      "institution": "Pemerintah Daerah Kabupaten Bangka Selatan",
      "value": "398.98 Jt",
      "url":
      "http://lpse.bangkaselatankab.go.id/eproc4/lelang/1474369/pengumumanlelang"
    },
    {
      "id": "1533340",
      "title": "Pengembangan Jaringan Perpipaan SPAM IKK Kec. Muntok",
      "institution": "Pemerintah Daerah Kabupaten Bangka Barat",
      "value": "1,7 M",
      "url":
      "http://lpse.bangkabaratkab.go.id/eproc4/lelang/1533340/pengumumanlelang"
    },
    {
      "id": "1414340",
      "title":
      "Pemasangan Jaringan dan Instalasi Listrik Untuk Kawasan Wisata Gunung Menumbing (DABA)",
      "institution": "Pemerintah Daerah Kabupaten Bangka Barat",
      "value": "4,8 M",
      "url":
      "http://lpse.bangkabaratkab.go.id/eproc4/lelang/1414340/pengumumanlelang"
    },
  ];


  List filter(String searchItem) {

    if(searchItem==""){
      return [];
    }

    List searchResult = [];
    var item;

    for (item in this.tender) {
      if (item["title"].toString().toLowerCase().contains(
          searchItem.toLowerCase())) {
        searchResult.add(item);
      }
    }

    return searchResult;
  }


}
