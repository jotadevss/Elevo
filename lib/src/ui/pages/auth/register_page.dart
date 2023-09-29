import 'package:asp/asp.dart';
import 'package:elevo/src/core/dto/create_user_dto.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/auth_logic.dart';
import 'package:elevo/src/core/validator/email_validator.dart';
import 'package:elevo/src/core/validator/name_validator.dart';
import 'package:elevo/src/core/validator/password_validate.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    final loginCredential = CreateUserDTO(name: _nameTextController.text, email: _emailTextController.text, password: _passwordTextController.text);
    createWithEmailAndPasswordAction.value = loginCredential;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = context.select(() => isLoadingState.value);
    final [showError as bool, errorMessage as String?] = context.select(() => [showAuthErrorAtom.value, authErrorMessage.value]);

    if (showError) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              margin: const EdgeInsets.symmetric(vertical: 18),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              decoration: BoxDecoration(
                color: kErrorColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const Gap(width: 12),
                  Flexible(
                    child: Text(
                      errorMessage ?? "Internal Error",
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        showAuthErrorAtom.value = false;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: (isLoading)
              ? Padding(
                  padding: EdgeInsets.only(top: (size.height / 2)),
                  child: const CircularProgressIndicator(color: kPrimaryColor),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(height: size.height / 10),
                    SvgPicture.asset('lib/assets/icons/logo.svg'),
                    const Gap(height: 44),
                    const Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(height: 16),
                    const Text(
                      "Create your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: kGrayColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(height: 12),
                            TextFormField(
                              controller: _nameTextController,
                              validator: (text) => UsernameValidator.validate(text),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                hintText: "Username...",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 12, fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xFF949494), width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: kErrorColor, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: kErrorColor, width: 1),
                                ),
                              ),
                            ),
                            const Gap(height: 26),
                            const Text(
                              "Email",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(height: 12),
                            TextFormField(
                              controller: _emailTextController,
                              validator: (text) => EmailValidator.validate(text),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                hintText: "user@email.com",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 12, fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xFF949494), width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: kErrorColor, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: kErrorColor, width: 1),
                                ),
                              ),
                            ),
                            const Gap(height: 26),
                            const Text(
                              "Password",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(height: 12),
                            TextFormField(
                              controller: _passwordTextController,
                              validator: (text) => PasswordValidate.validate(text),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                hintText: "Your password...",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 12, fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xFF949494), width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: kErrorColor, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: kErrorColor, width: 1),
                                ),
                              ),
                            ),
                            const Gap(height: 8),
                          ],
                        ),
                      ),
                    ),
                    const Gap(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44),
                      child: InkWell(
                        onTap: submit,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(height: 24),
                    if (!isFirstTimeInAppState.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Do you have an account?",
                            style: const TextStyle(
                              color: kGrayColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(width: 6),
                          InkWell(
                            onTap: () {
                              context.pop();
                            },
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            child: const Text(
                              "Sign In",
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Gap(height: size.height / 10),
                  ],
                ),
        ),
      ),
    );
  }
}
