import 'package:flutter/material.dart';
import 'package:myresto/feature/home/bloc/restaurant_bloc.dart';
import 'package:myresto/utils/styles.dart';

class ReviewForm extends StatelessWidget {
  final String restaurantId;
  final bool isLoading;
  final RestaurantBloc restaurantBloc;

  const ReviewForm({
    super.key,
    required this.restaurantId,
    required this.isLoading,
    required this.restaurantBloc,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 8),
        _buildTextField(reviewController),
        const SizedBox(height: 8),
        _buildSubmitButton(context, reviewController),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Write a Review',
      style: blackTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Write your review here',
      ),
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, TextEditingController controller) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              final reviewText = controller.text;
              if (reviewText.isNotEmpty) {
                restaurantBloc.add(
                  SendReviewEvent(
                    restaurantId: restaurantId,
                    name: 'Meisy',
                    review: reviewText,
                  ),
                );
                controller.clear();
              }
            },
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Submit Review'),
    );
  }
}
