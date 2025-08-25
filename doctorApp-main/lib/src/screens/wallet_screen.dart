import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/general_controller.dart';

import '../controllers/wallet_controller.dart';
import '../repositories/get_wallet_balance_repo.dart';
import '../repositories/get_wallet_transactions_repo.dart';
import '../repositories/get_wallet_withdrawals_repo.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';
import 'withdraw_amount_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  final walletLogic = Get.put(WalletController());

  bool isVisibleTransactionsHistory = true;

  @override
  void initState() {
    super.initState();
    // Get All Wallet Balance
    getMethod(context, getWalletBalanceURL, null, true, getWalletBalanceRepo);
    // Get All Wallet Transactions
    getMethod(context, getWalletTransactionURL, null, true,
        getWalletTransactionsRepo);
    // Get All Wallet Withdrawals
    getMethod(
        context, getWalletWithdrawalURL, null, true, getWalletWithdrawalsRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<WalletController>(builder: (walletController) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: "assets/icons/Sort.png",
              leadingOnTap: () {
                Scaffold.of(context).openDrawer();
              },
              titleText: LanguageConstant.wallet.tr,
            ),
          ),
          body: !walletController.allWalletTransactionLoader
              ? CustomVerticalSkeletonLoader(
                  height: 200.h,
                  highlightColor: AppColors.grey,
                  seconds: 2,
                  totalCount: 5,
                  width: 140.w,
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(18.w, 36.h, 18.w, 36.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  LanguageConstant.availableAmount.tr,
                                  style: AppTextStyles.bodyTextStyle14,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  Get.find<GetAllSettingsController>()
                                      .getDisplayAmount(int.parse(
                                          walletController
                                              .getWalletBalanceModel.data!)),
                                  style: AppTextStyles.bodyTextStyle13,
                                ),
                              ],
                            ),
                            ButtonWidgetTwo(
                              borderRadius: 10,
                              buttonIcon: Image.asset(
                                "assets/icons/right_bold.png",
                                height: 10.h,
                                color: Color(0xff535353),
                              ),
                              buttonText: LanguageConstant.withdrawAmount.tr,
                              buttonTextStyle: AppTextStyles.buttonTextStyle9,
                              onTap: () {
                                Get.to(const WithdrawAmountScreen());
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isVisibleTransactionsHistory == true
                              ? Text(
                                  LanguageConstant.transactionsHistory.tr,
                                  style: AppTextStyles.headingTextStyle1,
                                )
                              : Text(
                                  LanguageConstant.withdrawalsHistory.tr,
                                  style: AppTextStyles.headingTextStyle1,
                                ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: 0),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (isVisibleTransactionsHistory == true) {
                                  isVisibleTransactionsHistory = false;
                                } else if (isVisibleTransactionsHistory ==
                                    false) {
                                  isVisibleTransactionsHistory = true;
                                }
                              });
                            },
                            child: Text(
                              isVisibleTransactionsHistory == true
                                  ? LanguageConstant.withdrawals.tr
                                  : LanguageConstant.transactions.tr,
                              style: AppTextStyles.buttonTextStyle2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      isVisibleTransactionsHistory == true
                          ? walletController
                                  .walletTransactionForPagination.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: walletController
                                        .walletTransactionForPagination.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            14.w, 6.h, 14.w, 6.h),
                                        margin: EdgeInsets.only(bottom: 18.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${walletController.walletTransactionForPagination[index].id}",
                                                  style: AppTextStyles
                                                      .bodyTextStyle5,
                                                ),
                                                SizedBox(width: 12.w),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${walletController.walletTransactionForPagination[index].type}",
                                                      style: AppTextStyles
                                                          .bodyTextStyle5,
                                                    ),
                                                    Text(
                                                      generalController.displayDate(
                                                          walletController
                                                              .walletTransactionForPagination[
                                                                  index]
                                                              .createdAt),
                                                      style: AppTextStyles
                                                          .bodyTextStyle8,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  Get.find<
                                                          GetAllSettingsController>()
                                                      .getDisplayAmount(int
                                                          .parse(walletController
                                                              .walletTransactionForPagination[
                                                                  index]
                                                              .amount!)),
                                                  style: AppTextStyles
                                                      .bodyTextStyle6,
                                                ),
                                                SizedBox(width: 12.w),
                                                ButtonWidgetFour(
                                                    onTap: () {},
                                                    borderColor:
                                                        AppColors.transparent)
                                              ],
                                            ),
                                          ],
                                        ),
                                        // ),
                                      );
                                    },
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 100.h, 0, 100.h),
                                  child: Center(
                                    child: Text(
                                      LanguageConstant.noDataFound.tr,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                  ),
                                )
                          : walletController
                                  .walletWithdrawalForPagination.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: walletController
                                        .walletWithdrawalForPagination.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            14.w, 6.h, 14.w, 6.h),
                                        margin: EdgeInsets.only(bottom: 18.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${walletController.walletWithdrawalForPagination[index].id}",
                                                  style: AppTextStyles
                                                      .bodyTextStyle5,
                                                ),
                                                SizedBox(width: 12.w),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${walletController.walletWithdrawalForPagination[index].additionalNote}",
                                                      style: AppTextStyles
                                                          .bodyTextStyle8,
                                                    ),
                                                    Text(
                                                      generalController.displayDate(
                                                          walletController
                                                              .walletWithdrawalForPagination[
                                                                  index]
                                                              .createdAt),
                                                      style: AppTextStyles
                                                          .bodyTextStyle8,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  Get.find<
                                                          GetAllSettingsController>()
                                                      .getDisplayAmount(
                                                          walletController
                                                              .walletWithdrawalForPagination[
                                                                  index]
                                                              .amount!),
                                                  style: AppTextStyles
                                                      .bodyTextStyle6,
                                                ),
                                                SizedBox(width: 12.w),
                                                ButtonWidgetFour(
                                                    onTap: () {},
                                                    borderColor:
                                                        AppColors.transparent)
                                              ],
                                            ),
                                          ],
                                        ),
                                        // ),
                                      );
                                    },
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 100.h, 0, 100.h),
                                  child: Center(
                                    child: Text(
                                      LanguageConstant.noDataFound.tr,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
        );
      });
    });
  }
}
