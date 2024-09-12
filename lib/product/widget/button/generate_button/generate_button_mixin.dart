part of 'generate_button.dart';

mixin _GenerateButtonMixin on MountedMixin<GenerateButton>, State<GenerateButton> {
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _isLoadingNotifier.value = false;
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  Future<void> _onPressed(BuildContext context) async {
    _isLoadingNotifier.value = true;

    await safeOperation(() async {
      final imageUrl = await _fetchBreedImage();

      if (imageUrl != null) {
        _showImageDialog(context, imageUrl);
      } else {
        _showErrorAlert(context);
      }

      _isLoadingNotifier.value = false;
    });
  }

  Future<String?> _fetchBreedImage() async {
    final repo = context.read<BreedsBloc>().dogRepository;
    return await repo.fetchRandomBreedImage(widget.breed ?? "");
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ProjectRadius.normal.value),
          ),
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(ProjectRadius.normal.value),
                child: Image.network(
                  imageUrl,
                  height: context.sized.dynamicHeight(.3),
                  width: context.sized.dynamicWidth(.5),
                  fit: BoxFit.cover,
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              CorneredIconButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorAlert(BuildContext context) {
    Utils.showAlert(context, "Breed not found", "Error", () {});
  }
}
