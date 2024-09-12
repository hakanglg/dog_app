part of 'expandable_search.dart';

mixin _ExpandableSearchFieldMixin on State<ExpandableSearchField> ,SingleTickerProviderStateMixin<ExpandableSearchField>  {


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


}