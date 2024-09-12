import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:dogapp/product/widget/draggable_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';


class ExpandableSearchField extends StatefulWidget {
  final Function(String) onSearch;

  const ExpandableSearchField({Key? key, required this.onSearch}) : super(key: key);

  @override
  _ExpandableSearchFieldState createState() => _ExpandableSearchFieldState();
}

class _ExpandableSearchFieldState extends State<ExpandableSearchField> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;
  bool _isFullyExpanded = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_isExpanded) {
        _expandToHalf();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _expandToHalf() {
    setState(() {
      _isExpanded = true;
      _isFullyExpanded = false;
      _controller.animateTo(0.5);
    });
  }

  void _expandToFull() {
    setState(() {
      _isFullyExpanded = true;
      _controller.forward();
    });
  }

  void _collapse() {
    setState(() {
      _isExpanded = false;
      _isFullyExpanded = false;
      _controller.reverse();
      _focusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _isExpanded ? EdgeInsets.zero : context.padding.horizontalNormal,
      child: GestureDetector(
        onTap: _isExpanded ? null : _expandToHalf,
        onVerticalDragUpdate: (details) {
          if (_isExpanded && details.primaryDelta! > 10) {
            _collapse();
          } else if (_isExpanded && !_isFullyExpanded && details.primaryDelta! < -10) {
            _expandToFull();
          }
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            double height = Tween<double>(
              begin: 52.0,
              end: MediaQuery.of(context).size.height * 0.8,
            ).evaluate(_animation);

            return Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ProjectRadius.medium.value),
              ),
              child: Column(
                children: [
                  if (_isExpanded) const DraggableDivider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: context.padding.horizontalNormal,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: context.general.textTheme.bodyMedium,
                                    focusNode: _focusNode,
                                    decoration: const InputDecoration(
                                      hintText: 'Search',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      context.read<BreedsBloc>().add(SearchBreeds(value)); // BLoC'a arama sorgusu gönderiliyor
                                    },
                                    onSubmitted: (value) {
                                      _collapse();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}