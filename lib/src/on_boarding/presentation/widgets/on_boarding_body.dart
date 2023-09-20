import 'package:education_app/src/on_boarding/domain/entities/page_content_ent.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContentEnt, super.key});

  final PageContentEnt pageContentEnt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('이거 뭐꼬?'),
      ],
    );
  }
}
