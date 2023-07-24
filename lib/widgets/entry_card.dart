// 3rd-party Packages
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";

// Local
import 'package:easy_tracker/utils/datetime_util.dart';
import "package:easy_tracker/utils/themes.dart";

// Card-like Widget displaying income or expense information
// amount positive -> income, negative -> expense
// name can be Null but DO NOT DO THAT

String formatUSD(double n) {
  return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(n.abs());
}

class EntryCard extends StatelessWidget {
  final int id;
  final String? name;
  final double amount;
  final int timestamp;
  final String? description;

  const EntryCard({
    Key? key,
    required this.id,
    required this.name,
    required this.amount,
    required this.timestamp,
    required this.description
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: fgWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [generalShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 230,
                child: Text(
                  name!,
                  style: bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              Text(
                timestampToDate(timestamp),
                style: bodyNumSmall,
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: Text(
                  description!,
                  style: bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (amount > 0)
                      SvgPicture.asset(
                        'assets/svg/eva_arrow-up-fill.svg',
                        height: 24,
                        width: 24,
                      ),
                    if (amount < 0)
                      SvgPicture.asset(
                        'assets/svg/eva_arrow-down-fill.svg',
                        height: 24,
                        width: 24,
                      ),
                    Text(
                      formatUSD(amount),
                      style: bodyNumMedium,
                    )
                  ]
                )
              )
            ]
          )
        ],
      ),
    );
  }
}