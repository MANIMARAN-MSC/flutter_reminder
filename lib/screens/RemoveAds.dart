import 'package:flutter/material.dart';
class RemoveAds extends StatefulWidget {
  const RemoveAds({super.key});

  @override
  State<RemoveAds> createState() => _RemoveAdsState();
}

class _RemoveAdsState extends State<RemoveAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RemoveAds"),
      ),
      body: Center(
        child: Text("RemoveAds"),
      ),
    );
  }
}
