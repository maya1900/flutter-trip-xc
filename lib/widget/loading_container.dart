import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool? cover;

  const LoadingContainer({Key? key, required this.isLoading, this.cover = false, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover! ? !isLoading ? child : _loadingView : Stack(
      children: <Widget>[
        child,
        if (isLoading) _loadingView,
      ],
    );
  }

  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}