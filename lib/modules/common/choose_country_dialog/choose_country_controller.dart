import '../../../config/config.dart';

class ChooseCountryController extends BaseController {
  final searchTextController = TextEditingController();
  final scrollController = ScrollController();

  final countryList = <AppCountry>[];
  final filteredList = <AppCountry>[].obs;

  final selectedCountryId = (-1).obs;

  Paginated<AppCountry>? paginatedData;
  var isLoading = false;
  var searchTerm = '';

  @override
  void onInit() {
    super.onInit();

    searchTextController.addListener(() {
      final searchTerm = searchTextController.text.trim().toLowerCase();
      if (searchTerm.isEmpty) {
        filteredList.assignAll(countryList);
      } else {
        final list = countryList.where((element) => element.name.toLowerCase().contains(searchTerm));
        filteredList.assignAll(list);
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!isLoading && searchTerm.isEmpty && paginatedData?.nextPageUrl != null) {
          isLoading = true;
          _getCountry((paginatedData?.currentPage ?? 0) + 1);
        }
      }
    });

    _getCountry();
  }

  void _getCountry([int? nextPage]) {
    final map = <String, dynamic>{};

    if (nextPage != null) {
      map['page'] = nextPage;
    }

    callApi(apiClient.countryList(map), showLoader: false).then((value) {
      isLoading = false;
      paginatedData = value;
      if (value != null) {
        countryList.addAll(value.data ?? []);
        filteredList.assignAll(countryList);
      }
    });
  }
}
