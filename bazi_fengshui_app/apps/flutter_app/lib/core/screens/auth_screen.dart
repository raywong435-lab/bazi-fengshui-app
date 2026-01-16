import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/application/auth_provider.dart';

/// Authentication screen with sign in/sign up tabs
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_isSignUp) {
      await ref.read(signUpControllerProvider.notifier).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
          );
    } else {
      await ref.read(signInControllerProvider.notifier).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpControllerProvider);
    final signInState = ref.watch(signInControllerProvider);
    final isLoading = signUpState.isLoading || signInState.isLoading;

    // Show error if any
    ref.listen<AsyncValue<void>>(
      _isSignUp ? signUpControllerProvider : signInControllerProvider,
      (_, state) {
        if (state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUp ? '註冊' : '登入'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_isSignUp)
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '姓名',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_isSignUp && (value == null || value.isEmpty)) {
                        return '請輸入姓名';
                      }
                      return null;
                    },
                  ),
                if (_isSignUp) const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '電子郵件',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入電子郵件';
                    }
                    if (!value.contains('@')) {
                      return '請輸入有效的電子郵件';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '密碼',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入密碼';
                    }
                    if (value.length < 6) {
                      return '密碼至少需要 6 個字符';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(_isSignUp ? '註冊' : '登入'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                          });
                        },
                  child: Text(
                    _isSignUp ? '已有帳戶？立即登入' : '沒有帳戶？立即註冊',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
