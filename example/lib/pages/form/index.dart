import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../logger/logger.dart';
import 'package:get/get.dart';

class  FormPreview extends StatefulWidget {
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
    final countryController = TextEditingController(text: 'China');
    final dateController = TextEditingController(text: '2024-11-09');
    final genderController = TextEditingController(text: 'female');
    final formDisabled = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件'),
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
              Obx(() => EForm(
                      key: formController.key,
                      labelPosition: EFormLabelPosition.top,
                      controller: formController,
                      // disabled: formDisabled.value,
                      readOnly: formDisabled.value,
                      formItemTextStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                      labelWidth: 'auto',
                      children: [
                        ECard(
                          header: const Text('用户信息'),
                          child: Column(
                            children: [
                              EFormItem(
                                  label: 'UserName',
                                  isRequired: true,
                                  child: EInput(
                                    textController: usernameController,
                                    placeholder: '请输入用户名',
                                    size: ESizeItem.small,
                                  )),
                              EFormItem(
                                  label: 'FirstName',
                                  isRequired: true,
                                  labelPosition: EFormLabelPosition.left,
                                  child: EInput(
                                    textController: usernameController,
                                    placeholder: '请输入用户名',
                                    size: ESizeItem.small,
                                  )),
                              EFormItem(
                                  label: 'Gender',
                                  isRequired: true,
                                  child: ERadioGroup(
                                    textController: genderController,
                                    onChanged: (value) {},
                                    children: const [
                                      ERadio(label: 'Male', value: 'male'),
                                      ERadio(label: 'Female', value: 'female'),
                                    ],
                                  )),
                              EFormItem(
                                  label: 'Email',
                                  isRequired: true,
                                  labelRightChild: EButton(
                                    onPressed: () {
                                      // print('help');
                                    },
                                    isLink: true,
                                    size: ESizeItem.small,
                                    icon: Icons.help_outline,
                                  ),
                                  validator: () {
                                    final email = emailController.text.trim();
                                    if (email.isEmpty) {
                                      return '邮箱不能为空';
                                    }
                                    final emailRegex = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                                  label: 'Password',
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
                                  label: 'Confirm Password',
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
                                  label: 'Date Of Birth',
                                  isRequired: true,
                                  validator: () {
                                    if (dateController.text.isEmpty) {
                                      return '请选择日期';
                                    }
                                    return null;
                                  },
                                  child: EDatePicker(
                                    placeholder: '请选择日期',
                                    size: ESizeItem.small,
                                    type: CalendarType.date,
                                    textController: dateController,
                                    onSelect: (value) {
                                      // date = value ?? '';
                                    },
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
                                          final city =
                                              cityController.text.trim();
                                          if (city.isNotEmpty &&
                                              city.length > 50) {
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
                                                label: 'America',
                                                value: 'America'),
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
                              EFormItem(
                                label: 'Address',
                                labelPosition: 'top',
                                isRequired: true,
                                validator: () {
                                  return null;
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: EFormItem(
                                        label: '',
                                        isEmptyLabel: true,
                                        labelPosition: 'top',
                                        labelWidth: 0.0,
                                        isRequired: false,
                                        child: ESelect(
                                          options: [
                                            SelectOption(label: 'China', value: 'China'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: EFormItem(
                                        label: '',
                                        isEmptyLabel: true,
                                        labelPosition: 'top',
                                        isRequired: false,
                                        child: ESelect(
                                          options: [
                                            SelectOption(label: 'China', value: 'China'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
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
                                      text: '测试验证',
                                      onPressed: () {
                                        final validationResult =
                                            formController.valid();
                                        if (validationResult) {
                                          Loglevel.d('表单验证通过');
                                        } else {
                                          Loglevel.d('表单验证失败');
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: EButton(
                                      text: '重置表单',
                                      onPressed: () {
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
                                      text: '重置状态',
                                      onPressed: () {
                                        Loglevel.d(
                                            'formDisabled: ${formDisabled.value}');
                                        // 测试单个字段验证
                                        formDisabled.value =
                                            !formDisabled.value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])),

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
            ],
          ),
        ),
      ),

    );
  }
}
