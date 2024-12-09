import 'dart:developer';

import 'package:domainchat/app/servieces/api_serviece.dart';
import 'package:get/get.dart';

import '../models/domain_model.dart';
import '../models/message_model.dart';

class DomainController extends GetxController {

  var domainList = <DomainModel>[].obs;
  var domainNameList = [].obs;
  var registrationDone =false.obs;
  var loginDone =false.obs;
  DomainModel? selectedDomain;
  final RxList<Message> messageList = <Message>[].obs;

  @override
  void onInit() {
    fetchDomains();
    super.onInit();
  }

  Future<void> fetchDomains() async {
    try {
      List<DomainModel> domains = await ApiService.fetchDomains();
      domainList.value = domains;
      log("domains: ${domainList.length.toString()}");
      domainNameList.value= getDomainNames(domains);
    } catch (e) {
      log("Error fetching domains: $e");
    }
  }

  Future<void> createAccount(String email, String password)async{
    registrationDone.value=await ApiService.createAccount(email, password);
  }

  Future<void> login(String email, String password)async{
    loginDone.value=await ApiService.login(email, password);
  }



  List<String> getDomainNames(List<DomainModel> domainModels) {
    return domainModels.map((domainModel) => domainModel.domain ?? '').toList();
  }

}
