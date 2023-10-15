part of home_screen;

class _WeatherCardShimmer extends StatelessWidget {
  const _WeatherCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: Gradients.cardBlueGrad,
      ),
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    BoxShimmer.rounded(
                      height: 21,
                      width: double.infinity,
                    ),
                    SizedBox(height: 8),
                    BoxShimmer.rounded(
                      height: 36,
                      width: 120,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 27),
              BoxShimmer.rounded(height: 77, width: 77)
            ],
          ),
          SizedBox(height: 25),
          BoxShimmer.rounded(
            height: 21,
            width: 150,
          ),
          SizedBox(height: 14),
          BoxShimmer.rounded(
            height: 27,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
