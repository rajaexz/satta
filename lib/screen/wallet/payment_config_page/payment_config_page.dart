// views/payment_config_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/wallet/payment_config_page/controller/payment_config_controller.dart';
import 'package:winner11/screen/wallet/payment_config_page/model/PaymentConfig.dart';
import '../../../network/network_config.dart';

class PaymentConfigPage extends StatelessWidget {
  final PaymentConfigController controller = Get.put(PaymentConfigController(NetworkProvider()));

  @override
  Widget build(BuildContext context) {
    // Initialize data fetch
    controller.fetchPaymentConfig();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Config'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final config = controller.paymentConfig.value;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Support Number: ${config.supportNumber}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16.0),
                  _buildAvailableMethods(config.availableMethods),
                  const SizedBox(height: 16.0),
                  _buildAvailableMethodsDetails(config.availableMethodsDetails),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildAvailableMethods(AvailableMethods methods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Methods:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        Text('Bank Account: ${methods.bankAccount ? "Available" : "Not Available"}'),
        Text('UPI: ${methods.upi ? "Available" : "Not Available"}'),
        Text('QR Code: ${methods.qrCode ? "Available" : "Not Available"}'),
        const SizedBox(height: 8.0),
        Text('Payment Gateways:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ...methods.paymentGateway.map((gateway) => _buildPaymentGateway(gateway)).toList(),
      ],
    );
  }

  Widget _buildPaymentGateway(PaymentGateway gateway) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type: ${gateway.type}'),
        Text('Video: ${gateway.video}'),
        Text('Notice: ${gateway.notice}'),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildAvailableMethodsDetails(AvailableMethodsDetails details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Default Method: ${details.defaultMethod}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        Text('UPI Limit: ${details.upiLimit}'),
        Text('Amount Configuration: ${details.amountConfiguration}'),
        const SizedBox(height: 8.0),
        _buildPaymentMethod('UPI', details.upi),
        _buildPaymentMethod('Small Amount UPI', details.smallAmountUpi),
        _buildPaymentMethod('Large Amount UPI', details.largeAmountUpi),
        _buildBankAccount(details.bankAccount),
        _buildQrCode(details.qrCode),
      ],
    );
  }

  Widget _buildPaymentMethod(String title, PaymentMethod method) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        Text('UPI Name: ${method.upiName}'),
        Text('UPI ID: ${method.upiId}'),
        Text('Remark: ${method.remark}'),
        Text('Type: ${method.type}'),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildBankAccount(BankAccount account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bank Account:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        Text('Video: ${account.video}'),
        Text('Notice: ${account.notice}'),
        Text('Bank Name: ${account.bankName}'),
        Text('Account Holder Name: ${account.accountHolderName}'),
        Text('Account No: ${account.accountNo}'),
        Text('IFSC Code: ${account.ifscCode}'),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildQrCode(QrCode qr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('QR Code:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        Text('Video: ${qr.video}'),
        Text('Notice: ${qr.notice}'),
        Text('QR Image: ${qr.qrImage}'),
        Text('QR UPI ID: ${qr.qrUpiId}'),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
