import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({super.key});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  final int _total = 105;
  int _pageSize = 10;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pagination 分页',
          style: TextStyle(fontSize: 15),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            EPagination(
              total: _total,
              pageSize: _pageSize,
              spacing: 5,
              layout: const [
                EPaginationLayout.total,
                EPaginationLayout.prev,
                EPaginationLayout.pager,
                EPaginationLayout.next,
                EPaginationLayout.sizes,
              ],
              maxPageCount: 2,
              currentPage: _currentPage,
              onPageChange: (p) => setState(() {
                _currentPage = p;
              }),
              onPageSizeChange: (s) => setState(() {
                _pageSize = s;
              }),
            ),
            const SizedBox(height: 32),
            const Text('自定义颜色'),
            const SizedBox(height: 16),
            EPagination(
              total: _total,
              maxPageCount: 2,
              pageSize: _pageSize,
              currentPage: _currentPage,
              customColor: Colors.red,
              onPageChange: (p) => setState(() => _currentPage = p),
              onPageSizeChange: (s) => setState(() {
                _pageSize = s;
                _currentPage = 1;
              }),
            ),
            const SizedBox(height: 32),
            const Text('快速跳转'),
            const SizedBox(height: 16),
            EPagination(
              total: _total,
              pageSize: _pageSize,
              currentPage: _currentPage,
              layout: const [
                EPaginationLayout.pager,
                EPaginationLayout.jumper,
              ],
              isRound: true,
              onPageChange: (p) => setState(() => _currentPage = p),
            ),
            const Text('自定义背景颜色'),
            const SizedBox(height: 16),
            EPagination(
              total: _total,
              pageSize: _pageSize,
              currentPage: _currentPage,
              showBackground: false,
              onPageChange: (p) => setState(() => _currentPage = p),
              onPageSizeChange: (s) => setState(() {
                _pageSize = s;
                _currentPage = 1;
              }),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
