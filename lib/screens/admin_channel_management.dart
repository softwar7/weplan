import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/delete_button.dart';
import 'package:weplan/components/modify_button.dart';
import 'package:weplan/screens/forms/channel_form.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/viewmodels/channel.dart';

class ChannelManagement extends StatelessWidget {
  const ChannelManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var items = context.watch<ChannelService>().list;
    // var formKey = GlobalKey<FormState>();
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: context.read<ChannelService>().updateChannels,
        child: items.isEmpty
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: const Center(child: Text('채널이 없습니다.')),
                ),
              )
            : ListView.separated(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].name),
                    subtitle: Text(items[index].place),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    onTap: () {
                      ChannelViewModel channel = items[index];
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    channel.name,
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Text(channel.place),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ModifyButton(
                                        alertDialog: ChannelFormAlertDialog(
                                            channel: channel,),
                                      ),
                                      DeleteButton(
                                        title: '채널 삭제',
                                        handleDelete: () async {
                                          await channel
                                              .deleteChannel(verbose: true)
                                              .then(
                                                (_) => context
                                                    .read<ChannelService>()
                                                    .updateChannels(),
                                              );
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, thickness: 0.1),
              ),
      ),
    );
  }
}
