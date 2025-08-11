import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class FormPreview extends StatefulWidget {
  const FormPreview({super.key});

  @override
  State<FormPreview> createState() => _FormPreviewState();
}

class _FormPreviewState extends State<FormPreview> {
  @override
  Widget build(BuildContext context) {
    final formController = EFormController();

    // 创建控制器来获取输入值
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final ageController = TextEditingController();
    final bioController = TextEditingController();
    final cityController = TextEditingController();
    final countryController = TextEditingController(text: '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('表单组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 表单
              EForm(
                  key: formController.key,
                  labelPosition: EFormLabelPosition.left,
                  controller: formController,
                  labelWidth: 'auto',
                  children: [
                    ECard(
                      header: const Text('用户信息'),
                      child: Column(
                        children: [
                          EFormItem(
                              label: 'username',
                              isRequired: true,
                              child: EInput(
                                textController: usernameController,
                                placeholder: '请输入用户名',
                                size: ESizeItem.small,
                              )),
                          EFormItem(
                              label: 'email',
                              isRequired: true,
                              validator: () {
                                final email = emailController.text.trim();
                                if (email.isEmpty) {
                                  return '邮箱不能为空';
                                }
                                final emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(email)) {
                                  return '请输入正确的邮箱格式';
                                }
                                return null;
                              },
                              child: EInput(
                                textController: emailController,
                                placeholder: '请输入邮箱',
                                size: ESizeItem.small,
                              )),
                          EFormItem(
                              label: 'password',
                              isRequired: true,
                              validator: () {
                                final password = passwordController.text;
                                if (password.isEmpty) {
                                  return '密码不能为空';
                                }
                                if (password.length < 6) {
                                  return '密码长度不能少于6个字符';
                                }
                                if (password.length > 20) {
                                  return '密码长度不能超过20个字符';
                                }
                                return null;
                              },
                              child: EInput(
                                textController: passwordController,
                                placeholder: '请输入密码',
                                size: ESizeItem.small,
                                password: true,
                              )),
                          EFormItem(
                              label: 'confirm',
                              isRequired: true,
                              validator: () {
                                final confirmPassword =
                                    confirmPasswordController.text;
                                if (confirmPassword.isEmpty) {
                                  return '请确认密码';
                                }
                                if (confirmPassword !=
                                    passwordController.text) {
                                  return '两次输入的密码不一致';
                                }
                                return null;
                              },
                              child: EInput(
                                textController: confirmPasswordController,
                                placeholder: '请再次输入密码',
                                size: ESizeItem.small,
                                password: true,
                              )),
                          EFormItem(
                              label: 'age',
                              isRequired: false,
                              validator: () {
                                final age = ageController.text.trim();
                                if (age.isNotEmpty) {
                                  final ageNum = int.tryParse(age);
                                  if (ageNum == null) {
                                    return '请输入有效的年龄';
                                  }
                                  if (ageNum < 0 || ageNum > 120) {
                                    return '年龄必须在0-120之间';
                                  }
                                }
                                return null;
                              },
                              child: EInput(
                                textController: ageController,
                                placeholder: '请输入年龄',
                                size: ESizeItem.small,
                              )),
                          EFormItem(
                              label: 'description',
                              isRequired: false,
                              validator: () {
                                final bio = bioController.text.trim();
                                if (bio.isNotEmpty && bio.length > 200) {
                                  return '个人简介不能超过200个字符';
                                }
                                return null;
                              },
                              child: EInput(
                                textController: bioController,
                                placeholder: '请输入个人简介',
                                size: ESizeItem.small,
                              )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: EFormItem(
                                    label: 'City',
                                    isRequired: false,
                                    labelPosition: EFormLabelPosition.top,
                                    validator: () {
                                      final city = cityController.text.trim();
                                      if (city.isNotEmpty && city.length > 50) {
                                        return '城市名称不能超过50个字符';
                                      }
                                      return null;
                                    },
                                    child: EInput(
                                      textController: cityController,
                                      placeholder: '请输入城市',
                                      size: ESizeItem.small,
                                    )),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: EFormItem(
                                    label: 'Country',
                                    isRequired: false,
                                    labelPosition: EFormLabelPosition.top,
                                    validator: () {
                                      final country =
                                          countryController.text.trim();
                                      if (country.isEmpty) {
                                        return '错误';
                                      }
                                      return null;
                                    },
                                    child: ESelect(
                                      key: ValueKey(countryController
                                          .text), // 添加 key 确保重置时重建
                                      options: [
                                        const SelectOption(
                                            label: 'China', value: 'China'),
                                        const SelectOption(
                                            label: 'America', value: 'America'),
                                        const SelectOption(
                                            label: 'Japan', value: 'Japan'),
                                      ],
                                      placeholder: '请选择国家',
                                      size: ESizeItem.small,
                                      value: countryController.text,
                                      onChanged: (value) {
                                        countryController.text = value;
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ECard(
                      header: const Text('表单操作'),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: EButton(
                                  text: '提交表单',
                                  onPressed: () {
                                    final validationResult =
                                        formController.valid();

                                    if (validationResult) {
                                      // 验证通过，显示成功信息
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('表单验证通过！'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );

                                      // 打印表单数据
                                      print('表单数据:');
                                      print('用户名: ${usernameController.text}');
                                      print('邮箱: ${emailController.text}');
                                      print('年龄: ${ageController.text}');
                                      print('简介: ${bioController.text}');
                                    } else {
                                      // 验证失败，显示错误信息
                                      print('验证失败，显示错误信息');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('请检查表单填写是否正确'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: EButton(
                                  text: '重置表单',
                                  onPressed: () {
                                    formController.reset();
                                    // 清空所有输入框
                                    usernameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                    confirmPasswordController.clear();
                                    ageController.clear();
                                    bioController.clear();
                                    cityController.clear();
                                    countryController.clear();
                                    // 强制刷新界面，确保 ESelect 组件能正确重置
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: EButton(
                                  text: '清除验证',
                                  onPressed: () {
                                    formController.clearValidate();
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: EButton(
                                  text: '测试验证',
                                  onPressed: () {
                                    // 测试单个字段验证
                                    print('测试表单验证...');
                                    final isValid = formController.valid();
                                    print('表单验证结果: $isValid');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),

              const SizedBox(height: 16),

              // 不同标签位置的示例
              ECard(
                header: const Text('不同标签位置示例'),
                child: Column(
                  children: [
                    EForm(
                      key: EFormController().key,
                      labelPosition: EFormLabelPosition.top,
                      controller: EFormController(),
                      children: [
                        EFormItem(
                          label: '顶部标签',
                          isRequired: true,
                          validator: () {
                            return null; // 示例验证器
                          },
                          child: const EInput(
                            placeholder: '请输入内容',
                            size: ESizeItem.small,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    EForm(
                      key: EFormController().key,
                      labelPosition: EFormLabelPosition.right,
                      controller: EFormController(),
                      children: [
                        EFormItem(
                          label: '右对齐标签',
                          isRequired: true,
                          validator: () {
                            return null; // 示例验证器
                          },
                          child: const EInput(
                            placeholder: '请输入内容',
                            size: ESizeItem.small,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 验证规则说明
              ECard(
                header: const Text('验证规则说明'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('用户名验证规则:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• 必填字段'),
                    const Text('• 长度3-20个字符'),
                    const SizedBox(height: 8),
                    const Text('邮箱验证规则:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• 必填字段'),
                    const Text('• 符合邮箱格式'),
                    const SizedBox(height: 8),
                    const Text('密码验证规则:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• 必填字段'),
                    const Text('• 长度6-20个字符'),
                    const SizedBox(height: 8),
                    const Text('确认密码验证规则:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• 必填字段'),
                    const Text('• 与密码一致'),
                    const SizedBox(height: 8),
                    const Text('年龄验证规则:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• 可选字段'),
                    const Text('• 0-120之间的整数'),
                    const SizedBox(height: 8),
                    const Text('简介验证规则:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('• 可选字段'),
                    const Text('• 不超过200个字符'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
