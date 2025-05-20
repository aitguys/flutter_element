import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ScrollbarPage extends StatelessWidget {
  const ScrollbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollbar Examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EScrollbar(
              onScroll: (scrollController) {
                print(scrollController.position);
              },
              maxHeight: 400,
              native: true,
              child: Column(
                children: List.generate(
                  20,
                  (index) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: EColorTypes.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: TextStyle(color: EColorTypes.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text('Basic Scrollbar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EScrollbar(
              height: 200,
              onScroll: (scrollController) {
                print(scrollController.position);
              },
              child: Column(
                children: List.generate(
                  20,
                  (index) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: EColorTypes.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: TextStyle(color: EColorTypes.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Horizontal Scrollbar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EScrollbar(
              height: 100,
              horizontal: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    20,
                    (index) => Container(
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: EColorTypes.danger.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'Item ${index + 1}',
                          style: TextStyle(color: EColorTypes.danger),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Max Height Scrollbar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EScrollbar(
              maxHeight: 200,
              child: Column(
                children: List.generate(
                  10,
                  (index) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: EColorTypes.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: TextStyle(color: EColorTypes.success),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Always Visible Scrollbar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EScrollbar(
              height: 200,
              always: true,
              child: Column(
                children: List.generate(
                  20,
                  (index) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: EColorTypes.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: TextStyle(color: EColorTypes.warning),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
