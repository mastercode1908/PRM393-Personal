import 'package:flutter/material.dart';
import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Tính Năng Nổi Bật",
      "description": "Trình bày các tính năng ưu việt, giúp bạn làm việc hiệu quả và nhanh chóng.",
      "image": "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&auto=format&fit=crop"
    },
    {
      "title": "Dễ Dàng Quản Lý",
      "description": "Theo dõi mọi tiến độ công việc ngay trên thiết bị di động của bạn ở bất cứ đâu.",
      "image": "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&auto=format&fit=crop"
    },
    {
      "title": "Bảo Mật Tuyệt Đối",
      "description": "Dữ liệu của bạn luôn được mã hóa và bảo vệ với tiêu chuẩn cao nhất.",
      "image": "https://images.unsplash.com/photo-1563986768494-4dee2763ff0f?w=800&auto=format&fit=crop"
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Logic state: Sử dụng PageView.builder cho Carousel. Sự kiện: Vuốt để lướt xem.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('GIỚI THIỆU TÍNH NĂNG', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildPageContent(
                    title: onboardingData[index]["title"]!,
                    description: onboardingData[index]["description"]!,
                    imageUrl: onboardingData[index]["image"]!,
                  );
                },
              ),
            ),
            
            // Indicator and Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back / Skip Button
                  TextButton(
                    onPressed: () {
                      if (_currentPage == 0) {
                        // Skip straight to Home
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      } else {
                        // Go back one page
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
                    child: Text(_currentPage == 0 ? "Bỏ qua" : "Trở lại", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  
                  // Dot Indicators
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      onboardingData.length,
                      (index) => _buildDot(index: index),
                    ),
                  ),
                  
                  // Next / Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        // End of onboarding, go to Home Screen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(_currentPage == onboardingData.length - 1 ? "Bắt đầu" : "Tiếp", style: const TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({required String title, required String description, required String imageUrl}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // Texts
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.purple : Colors.purple.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
