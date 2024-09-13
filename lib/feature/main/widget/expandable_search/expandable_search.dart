import 'package:dogapp/product/utility/enum/project_enums.dart';
import 'package:dogapp/product/widget/draggable_divider.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

part 'expandable_search_mixin.dart';

final class ExpandableSearchField extends StatefulWidget {
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
        onVerticalDragUpdate: _handleVerticalDragUpdate,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return _buildSearchContainer(context);
          },
        ),
      ),
    );
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (_isExpanded && details.primaryDelta! > 10) {
      _collapse();
    } else if (_isExpanded && !_isFullyExpanded && details.primaryDelta! < -10) {
      _expandToFull();
    }
  }

  Widget _buildSearchContainer(BuildContext context) {
    double height = Tween<double>(
      begin: 52.0,
      end: MediaQuery.of(context).size.height * 0.8,
    ).evaluate(_animation);

    return Container(
      height: height,
      decoration: _buildBoxDecoration(),
      child: Column(
        children: [
          if (_isExpanded) const DraggableDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: context.padding.horizontalNormal,
                child: _buildSearchField(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(ProjectRadius.medium.value),
      boxShadow: !_isExpanded
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(.5),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 2.0),
              ),
            ]
          : null,
    );
  }

  Widget _buildSearchField() {
    return Row(
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
            onSubmitted: (_) => _collapse(),
          ),
        ),
      ],
    );
  }
}
