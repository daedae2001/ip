import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ip/business_logic/model/channel.dart';
import 'package:ip/business_logic/provider/channel_Provider.dart';

final countryProvider =
    Provider<AsyncValue<Map<String, List<ChannelObj>>>>((ref) {
  Map<String, List<ChannelObj>> sortedByCountry = {};

  final channels = ref.watch(mainChannels);
  print("zingerioinoi");

  return channels.when(
    data: (value) {
      int x = 0;
      for (ChannelObj channel in value!) {
        // print(sortedByCategory);

        if (channel.countries.isNotEmpty) {
          x++;

          for (String element in channel.countries) {
            if (element.isNotEmpty) {
              sortedByCountry[element] = [
                ...?sortedByCountry[element],
                channel
              ];
            }
          }
        }
      }
      return AsyncValue.data(sortedByCountry);
    },
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    loading: AsyncValue.loading,
  );
});
