import 'package:asp/asp.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevo/src/core/dto/sign_in_dto.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/auth_logic.dart';
import 'package:elevo/src/core/validator/email_validator.dart';
import 'package:elevo/src/core/validator/password_validate.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    checkAuthAction.call();
    super.initState();
  }

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    final loginCredential = SignInDTO(email: _emailTextController.text, password: _passwordTextController.text);
    signInWithEmailAndPasswordAction.value = loginCredential;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(() => isLoadingState.value);
    final [showError as bool, errorMessage as String?] = context.select(() => [showAuthErrorAtom.value, authErrorMessage.value]);
    final canUseAuthBiometric = context.select(() => isAvailableAuthByBiometric.value);

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
      body: Center(
        child: (isLoading)
            ? const CircularProgressIndicator(color: kPrimaryColor)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('lib/assets/icons/logo.svg'),
                  const Gap(height: 44),
                  const Text(
                    "Hello Again!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(height: 16),
                  const Text(
                    "Sign in your account",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                child: const Text(
                                  "Forgot the password?",
                                  style: const TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(height: 44),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: canUseAuthBiometric
                                        ? () {
                                            authenticateWithBiometricAction.call();
                                          }
                                        : null,
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    child: Text(
                                      "Enter with fingerprint",
                                      style: TextStyle(
                                        color: canUseAuthBiometric ? kPrimaryColor : kGrayColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Gap(height: 4),
                                  Container(
                                    width: 130,
                                    child: const Center(
                                      child: DottedLine(
                                        dashColor: kPrimaryColor,
                                        lineThickness: 0.8,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
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
                          "Sign in",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: const TextStyle(
                          color: kGrayColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(width: 6),
                      InkWell(
                        onTap: () {
                          context.push(AppRouter.AUTH_REGISTER_PAGE_ROUTER);
                        },
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        child: const Text(
                          "Register",
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
