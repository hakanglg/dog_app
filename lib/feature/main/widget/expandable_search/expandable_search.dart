import 'package:dogapp/feature/bloc/breeds_bloc.dart';
import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:dogapp/product/widget/draggable_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part 'expandable_search_mixin.dart';

class ExpandableSearchField extends StatefulWidget {
  final Function(String) onSearch;

  const ExpandableSearchField({super.key, required this.onSearch});

  @override
  _ExpandableSearchFieldState createState() => _ExpandableSearchFieldState();
}

class _ExpandableSearchFieldState extends State<ExpandableSearchField>
    with SingleTickerProviderStateMixin, _ExpandableSearchFieldMixin {
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
                boxShadow: !_isExpanded
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 2.0), // Adjust for bottom shadow
                        ),
                      ]
                    : null,
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
                                    onChanged: widget.onSearch,
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
