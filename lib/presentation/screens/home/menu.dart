import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ip/business_logic/provider/category_provider.dart';
import 'package:ip/business_logic/provider/channel_card_provider.dart';
import 'package:ip/core/consts.dart';

import 'package:ip/presentation/screens/home/sorted_by_category_page.dart';
import 'package:ip/presentation/screens/home/sorted_by_countryPage.dart';
import 'package:ip/presentation/widgets/home_page_widget/big_card_channel.dart';
import 'package:ip/presentation/widgets/main_appbar.dart';

class Menu extends ConsumerWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelCard = ref.watch(channelCardProvider);

    final categories = ref.watch(categoryProvider);

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kBlackBg, kWhiteBg],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Column(
              children: [
                MainAppbar(
                  havSettingBtn: true,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.jm().format(DateTime.now()),
                        style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.white70,
                            fontSize: 15),
                      ),
                      Text(
                        DateFormat.yMMMd().format(DateTime.now()),
                        style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: categories.when(
                    data: (data) =>
                        OrientationBuilder(builder: (context, orientation) {
                      return GridView.count(
                        crossAxisCount:
                            orientation == Orientation.landscape ? 1 : 2,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: orientation == Orientation.landscape
                            ? Axis.horizontal
                            : Axis.vertical,
                        shrinkWrap: false,
                        children: List.generate(
                          channelCard.length,
                          (index) => FadeInUp(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => index == 0
                                            ? SortedByCountryPage(
                                                allChanellsCount:
                                                    channelCard[index]
                                                        .channelCount,
                                              )
                                            : SortedByCategoryPage(
                                                categoryName:
                                                    channelCard[index].name,
                                                channels: data[
                                                        channelCard[index]
                                                            .name] ??
                                                    [],
                                              ),
                                      )),
                                  child: BigCardChannels(
                                    index: index,
                                    size: size,
                                    channelsCount:
                                        channelCard[index].channelCount,
                                    icon: channelCard[index].iconAddress ??
                                        "https://upload.wikimedia.org/wikipedia/commons/f/f2/SiN_Logo.png",
                                    text: channelCard[index].name,
                                  ),
                                )),
                          ),
                        ),
                      );
                    }),
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                    loading: () =>
                        Lottie.asset(kLoading, width: size.width / 4),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
