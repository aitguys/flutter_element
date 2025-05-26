import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

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
      appBar: AppBar(title: const Text('Pagination 分页')),
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
              currentPage: _currentPage,
              onPageChange: (p) => setState(() => _currentPage = p),
            ),
            const SizedBox(height: 32),
            const Text('每页条数切换'),
            const SizedBox(height: 16),
            EPagination(
              total: _total,
              pageSize: _pageSize,
              currentPage: _currentPage,
              showSizeChanger: true,
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
              showJumper: true,
              onPageChange: (p) => setState(() => _currentPage = p),
            ),
          ],
        ),
      ),
    );
  }
}
