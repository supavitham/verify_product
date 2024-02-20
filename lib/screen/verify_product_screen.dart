import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verify_product/controller/verify_product_controller.dart';

class VerifyProductScreen extends StatefulWidget {
  const VerifyProductScreen({super.key});

  @override
  State<VerifyProductScreen> createState() => _VerifyProductScreenState();
}

class _VerifyProductScreenState extends State<VerifyProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VerifyProductController>().getStockProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<VerifyProductController>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: value.area,
                          decoration: const InputDecoration(
                            labelText: 'พื้นที่',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: value.codeProduct,
                          decoration: const InputDecoration(
                            labelText: 'รหัสสินค้า',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            value.checkAreaAndCodeProduct();
                          },
                          child: const Text("ตรวจสอบ"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (value.checkAreaAndCodeProductInStock)
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: value.number,
                            decoration: const InputDecoration(
                              labelText: 'จำนวน',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              value.keepDataCheck();
                            },
                            child: const Text("ยืนยัน"),
                          ),
                        )
                      ],
                    ),
                  const Text(
                    "รายการตรวจ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  ...value.keepStockCheck
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                _buildText(title: 'พื้นที่', val: e.area ?? ''),
                                const SizedBox(width: 8),
                                _buildText(
                                    title: 'รหัสสินค้า',
                                    val: e.codeProduct ?? ''),
                                const SizedBox(width: 8),
                                _buildText(
                                    title: 'จำนวน', val: '${e.stock ?? ''}'),
                                const SizedBox(width: 8),
                                _buildText(
                                    title: 'รอบที่ ${e.countCheck}',
                                    val: '${e.countCheck ?? ''}'),
                              ],
                            ),
                          ))
                      .toList(),
                  const SizedBox(height: 8),
                  const Text(
                    "สรุปการตรวจนับ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ...value.keepStockCheck
                      .where((element) => element.stockConfirm != null)
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                _buildText(title: 'พื้นที่', val: e.area ?? ''),
                                const SizedBox(width: 8),
                                _buildText(
                                    title: 'รหัสสินค้า',
                                    val: e.codeProduct ?? ''),
                                const SizedBox(width: 8),
                                _buildText(
                                    title: 'จำนวน', val: '${e.stock ?? ''}'),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText({required String title, required String val}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(val),
      ],
    );
  }
}
