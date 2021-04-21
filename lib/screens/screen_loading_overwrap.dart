import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_loading.dart';

class LoadingOverWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<ProviderLoading>(context).loading) {
      return CircularProgressIndicator();
      //   Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   color: Colors.grey.shade700.withOpacity(0x7C),
      //   child: CircularProgressIndicator(),
      // );
    } else {
      return Container();
    }
  }
}
