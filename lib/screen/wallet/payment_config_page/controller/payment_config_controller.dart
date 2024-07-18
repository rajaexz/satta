// controllers/payment_config_controller.dart
import 'package:get/get.dart';

import '../../../../network/api_path.dart';
import '../../../../network/network_config.dart';
import '../model/PaymentConfig.dart';

class PaymentConfigController extends GetxController {
  var paymentConfig = PaymentConfig(
    supportNumber: '',
    availableMethods: AvailableMethods(
      bankAccount: false,
      upi: false,
      qrCode: false,
      paymentGateway: [],
    ),
    availableMethodsDetails: AvailableMethodsDetails(
      defaultMethod: '',
      upiLimit: '',
      amountConfiguration: '',
      upi: PaymentMethod(upiName: '', upiId: '', remark: '', type: ''),
      smallAmountUpi: PaymentMethod(upiName: '', upiId: '', remark: '', type: ''),
      largeAmountUpi: PaymentMethod(upiName: '', upiId: '', remark: '', type: ''),
      bankAccount: BankAccount(
        video: '',
        notice: '',
        bankName: '',
        accountHolderName: '',
        accountNo: '',
        ifscCode: '',
      ),
      qrCode: QrCode(video: '', notice: '', qrImage: '', qrUpiId: ''),
    ),
  ).obs;

  var isLoading = false.obs;

  final NetworkProvider networkProvider;

  PaymentConfigController(this.networkProvider);

  void fetchPaymentConfig() async {
    try {
      isLoading(true);
        var response = await networkProvider.getCall(' ${ApiPath.baseUrl}payment_config' );
        paymentConfig.value = response.body;
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'Data is not available  empty',
        duration: Duration(seconds: 2),
      ));
    } finally {
      isLoading(false);
    }
  }
}
