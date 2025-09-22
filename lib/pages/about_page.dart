import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/hairline_divider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  String? _emailError;
  String? _nameError;
  String? _messageError;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _emailError == null &&
      _nameError == null &&
      _messageError == null &&
      _emailController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _messageController.text.isNotEmpty;

  void _validateEmail(String value) {
    final v = value.trim();
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    setState(() {
      if (v.isEmpty) {
        _emailError = 'Email is required';
      } else if (!emailRegex.hasMatch(v)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _validateName(String value) {
    final v = value.trim();
    setState(() {
      if (v.isEmpty) {
        _nameError = 'Sender name is required';
      } else if (v.length < 2) {
        _nameError = 'Please enter at least 2 characters';
      } else {
        _nameError = null;
      }
    });
  }

  void _validateMessage(String value) {
    final v = value.trim();
    setState(() {
      if (v.isEmpty) {
        _messageError = 'Message is required';
      } else if (v.length < 10) {
        _messageError = 'Message should be at least 10 characters';
      } else {
        _messageError = null;
      }
    });
  }

  Future<void> _submit() async {
    if (!_isFormValid || _submitting) return;
    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _submitting = false);

    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Success'),
        content: const Text('Your message has been sent successfully.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    setState(() {
      _emailController.clear();
      _nameController.clear();
      _messageController.clear();
      _emailError = 'Email is required';
      _nameError = 'Sender name is required';
      _messageError = 'Message is required';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final labelStyle = theme.textTheme.textStyle.copyWith(
      color: const Color(0x99000000),
      fontSize: 13,
    );
    final errorStyle = theme.textTheme.textStyle.copyWith(
      color: CupertinoColors.systemRed,
      fontSize: 12,
    );

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('About'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About This App',
                style: theme.textTheme.navLargeTitleTextStyle,
              ),
              const SizedBox(height: 12),
              const HairlineDivider(),
              const SizedBox(height: 16),
              Text(
                'This project was created to fulfill Module 1 of the Mobile Programming course at Universitas Muhammadiyah Malang, by Wiji Fiko Teren.',
                style: theme.textTheme.textStyle.copyWith(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 18),
              _AuthorCard(
                avatarUrl: 'https://avatars.githubusercontent.com/u/84434815?v=4',
                name: 'Wiji Fiko Teren',
                email: 'tobellord@gmail.com',
                website: 'https://wijifikoteren.streampeg.com',
              ),
              const SizedBox(height: 28),
              Text('Contact', style: labelStyle.copyWith(fontSize: 15)),
              const SizedBox(height: 8),
              _buildFieldLabel('Email', labelStyle),
              const SizedBox(height: 6),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: _validateEmail,
                clearButtonMode: OverlayVisibilityMode.editing,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              if (_emailError != null) ...[
                const SizedBox(height: 6),
                Text(_emailError!, style: errorStyle),
              ],
              const SizedBox(height: 14),
              _buildFieldLabel('Sender Name', labelStyle),
              const SizedBox(height: 6),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Your name',
                onChanged: _validateName,
                clearButtonMode: OverlayVisibilityMode.editing,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              if (_nameError != null) ...[
                const SizedBox(height: 6),
                Text(_nameError!, style: errorStyle),
              ],
              const SizedBox(height: 14),
              _buildFieldLabel('Message', labelStyle),
              const SizedBox(height: 6),
              CupertinoTextField(
                controller: _messageController,
                placeholder: 'Write your message…',
                onChanged: _validateMessage,
                minLines: 3,
                maxLines: 5,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              if (_messageError != null) ...[
                const SizedBox(height: 6),
                Text(_messageError!, style: errorStyle),
              ],
              const SizedBox(height: 20),
              const HairlineDivider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: _isFormValid && !_submitting ? _submit : null,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: _submitting
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CupertinoActivityIndicator(radius: 9),
                              SizedBox(width: 8),
                              Text('Submitting…'),
                            ],
                          )
                        : const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text, TextStyle style) {
    return Text(text, style: style);
  }
}

// HairlineDivider moved to ../widgets/hairline_divider.dart

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.website,
  });

  final String avatarUrl;
  final String name;
  final String email;
  final String website;

  Future<void> _openWebsite() async {
    final uri = Uri.parse(website);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Could not launch $website');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final infoStyle = theme.textTheme.textStyle.copyWith(fontSize: 14.5);
    final subStyle = theme.textTheme.textStyle.copyWith(
      color: const Color(0x99000000),
      fontSize: 13,
    );

    return GestureDetector(
      onTap: _openWebsite,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0x33000000), width: 0.5),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                avatarUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: infoStyle.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(email, style: subStyle),
                  Text(website, style: subStyle.copyWith(color: theme.primaryColor)),
                ],
              ),
            ),
            const Icon(CupertinoIcons.arrow_up_right_diamond, size: 18, color: Color(0x99000000)),
          ],
        ),
      ),
    );
  }
}
