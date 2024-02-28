import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ip/business_logic/model/channel.dart';
import 'package:ip/business_logic/provider/channel_Provider.dart';

final languageProvider =
    Provider<AsyncValue<Map<String, List<ChannelObj>>>>((ref) {
  final channels = ref.watch(mainChannels);
  Map<String, List<ChannelObj>> sortedByLanguage = {};
  return channels.when(
    data: (value) {
      for (ChannelObj channelObj in value!) {
        // log((channelObj.languages[0].name.toString()));
        if (channelObj.languages.isNotEmpty) {
          sortedByLanguage.keys.contains(channelObj.languages[0])
              ? print("language added before")
              : sortedByLanguage[channelObj.languages[0]] = [];
          sortedByLanguage[channelObj.languages[0]]?.add(channelObj);
        }
      }
      print("sisi");
      print(sortedByLanguage);
      return AsyncValue.data(sortedByLanguage);
    },
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    loading: AsyncValue.loading,
  );
});
