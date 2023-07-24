// 3rd-party Packages
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";

// Local
import "package:easy_tracker/utils/themes.dart";

// Card-like Widget at the top of main home page
// displays Net income of the current Month
// current Month is detected by DateTime.now()

String getDateRange() {
  DateTime now = DateTime.now();

  // to get the end date of last month,
  // subtract one day from date of next month
  DateTime end = DateTime(now.year, now.month + 1, 0);

  String month = DateFormat('MMM').format(now);
  String endDay = end.day.toString();
  String year = now.year.toString();

  return "Net $month 1 - $month $endDay, $year";
}

String calculateNet(double income, double expense) {
  double net = expense - income;
  return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(net.abs());
}

String formatUSD(double n) {
  return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(n.abs());
}

class NetCard extends StatefulWidget {
  final double income;
  final double expense;
  const NetCard({
    Key? key,
    required this.income,
    required this.expense
  }): super(key: key);

  @override
  State<NetCard> createState() => _NetCardState();
}

class _NetCardState extends State<NetCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        gradient: mainGradient,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [generalShadow],
      ),
      child: Column( // MAIN CARD's CHILD
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              getDateRange(),
              style: bodyMedium,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.income > widget.expense)
                  SvgPicture.asset(
                    'assets/svg/eva_arrow-up-fill.svg',
                    height: 30,
                    width: 30,
                  ),
                if (widget.income == widget.expense)
                  const Icon(
                    Icons.remove,
                    color: Colors.black12,
                    size: 34,
                  ),
                if (widget.income < widget.expense)
                  SvgPicture.asset(
                    'assets/svg/eva_arrow-down-fill.svg',
                    height: 30,
                    width: 30,
                  ),
                Text(
                  calculateNet(widget.income, widget.expense),
                  style: bodyNumLarge,
                ),
              ]
            )
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Income",
                  style: bodyMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/eva_arrow-up-fill.svg',
                      height: 24,
                      width: 24,
                    ),
                    Text(
                      formatUSD(widget.income),
                      style: bodyNumMedium,
                    )
                  ],
                )
              ]
            )
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Expense",
                  style: bodyMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/eva_arrow-down-fill.svg',
                      height: 24,
                      width: 24,
                    ),
                    Text(
                      formatUSD(widget.expense),
                      style: bodyNumMedium,
                    )
                  ],
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}