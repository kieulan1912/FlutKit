import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/payment_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late ThemeData theme;
  late PaymentController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(PaymentController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<PaymentController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  controller.goBack();
                },
                child: Icon(
                  FeatherIcons.chevronLeft,
                ),
              ),
              title: FxText.titleMedium(
                "Booking Details",
                fontWeight: 700,
              ),
              elevation: 0,
              centerTitle: true,
            ),
            body: Padding(
              padding: FxSpacing.x(20),
              child: Column(
                children: [
                  booking(),
                  FxSpacing.height(20),
                  Expanded(child: payments()),
                  FxSpacing.height(20),
                  FxButton.block(
                    onPressed: () {
                      controller.goBack();
                    },
                    elevation: 0,
                    child: FxText.labelLarge(
                      "Confirm",
                      color: theme.colorScheme.onPrimary,
                      fontWeight: 700,
                    ),
                  ),
                  FxSpacing.height(20),
                ],
              ),
            ),
          );
        });
  }

  Widget booking() {
    return FxContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FxContainer.rounded(
                      paddingAll: 4,
                      color: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.south_west,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 16,
                      ),
                    ),
                    FxSpacing.width(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.bodySmall(
                          "From:",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(2),
                        FxText.bodyMedium(
                          "15 March",
                          fontWeight: 700,
                        ),
                        FxSpacing.height(2),
                        FxText.bodySmall(
                          "10am - 12am",
                          xMuted: true,
                        ),
                      ],
                    ),
                  ],
                ),
                FxSpacing.height(20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FxContainer.rounded(
                      paddingAll: 4,
                      color: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.north_east,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 16,
                      ),
                    ),
                    FxSpacing.width(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.bodySmall(
                          "To:",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(2),
                        FxText.bodyMedium(
                          "20 March",
                          fontWeight: 700,
                        ),
                        FxSpacing.height(2),
                        FxText.bodySmall(
                          "10am - 12am",
                          xMuted: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          FxContainer.bordered(
            borderRadiusAll: Constant.containerRadius.xs,
            padding: FxSpacing.xy(12, 24),
            border: Border.all(color: theme.colorScheme.primary),
            child: Column(
              children: [
                Icon(
                  FeatherIcons.calendar,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                FxSpacing.height(8),
                FxText.bodySmall(
                  "Pick Date",
                  color: theme.colorScheme.primary,
                  fontWeight: 600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget payments() {
    return FxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.bodyLarge(
            "Payment Details",
            fontWeight: 700,
          ),
          FxSpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              payment("assets/brand/master-card.png", "Visa"),
              payment("assets/brand/google.png", "Google"),
              payment("assets/brand/master-card.png", "Master"),
              payment("assets/brand/paypal.png", "Paypal"),
            ],
          ),
          FxSpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.bodyMedium(
                'Subtotal',
                fontWeight: 600,
              ),
              FxText.bodyMedium(
                '\$135.5',
                fontWeight: 700,
              ),
            ],
          ),
          FxSpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.bodyMedium(
                'Tax (GST)',
                fontWeight: 600,
              ),
              FxText.bodyMedium(
                '\$ 10',
                fontWeight: 700,
              ),
            ],
          ),
          FxSpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.bodyMedium(
                    'Coupon Discount',
                    fontWeight: 600,
                  ),
                  FxText.bodySmall(
                    '-30%',
                    fontWeight: 600,
                    fontSize: 11,
                    xMuted: true,
                  ),
                ],
              ),
              FxText.bodyMedium(
                '- \$ 15',
                fontWeight: 700,
              ),
            ],
          ),
          FxSpacing.height(12),
          Row(
            children: [
              Expanded(child: FxSpacing.empty()),
              Expanded(
                  child: FxDottedLine(
                height: 2,
              ))
            ],
          ),
          FxSpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.bodyMedium(
                'Total',
                fontWeight: 600,
              ),
              FxText.bodyMedium(
                '\$ 130.5',
                fontWeight: 700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget payment(String image, String title) {
    return FxContainer.bordered(
      paddingAll: 12,
      child: Column(
        children: [
          Image(
            height: 24,
            image: AssetImage(image),
          ),
          FxSpacing.height(8),
          FxText.bodySmall(title),
        ],
      ),
    );
  }
}
