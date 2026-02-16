import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _lojaController = TextEditingController();
  final _redeController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _whatsController = TextEditingController();

  bool _obscurePassword = true;
  bool _modoCadastro = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.6)),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _lojaController.dispose();
    _redeController.dispose();
    _matriculaController.dispose();
    _whatsController.dispose();
    super.dispose();
  }

  void _sairCadastro() {
    setState(() {
      _modoCadastro = false;
      _lojaController.clear();
      _redeController.clear();
      _matriculaController.clear();
      _whatsController.clear();
    });
  }

  void _acaoLoginFake() {
    final email = _emailController.text.trim();
    final senha = _passwordController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha email e senha'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login (mock) realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _salvarCadastroFake() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro (mock) salvo'),
      ),
    );
    _sairCadastro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffffffff),
                  Color(0xFF288E0B),
                  Color(0xf0c80000),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 420),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.85),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 40,
                            offset: Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 1200),
                              builder: (_, value, __) => Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.blueAccent, Colors.indigo],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.local_pharmacy_sharp,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Drogaria tirei o nome..",
                              style: GoogleFonts.pacifico(
                                fontSize: 15,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Bem vindo Farma!',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _subText("Faça login para continuar"),
                            const SizedBox(height: 15),

                            // EMAIL
                            _campo('Email', Icons.email, _emailController),

                            const SizedBox(height: 2),

                            // SENHA
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: _decoracao(
                                'Senha',
                                Icons.lock_outline,
                                sufixo: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() => _obscurePassword = !_obscurePassword);
                                  },
                                ),
                              ),
                            ),

                            // CAMPOS DE CADASTRO
                            AnimatedSize(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              child: _modoCadastro
                                  ? Column(
                                children: [
                                  const SizedBox(height: 20),
                                  _campo('Loja', Icons.store, _lojaController),
                                  _campo('Rede', Icons.account_tree, _redeController),
                                  _campo('Matrícula', Icons.badge, _matriculaController),
                                  _campo(
                                    'WhatsApp',
                                    Icons.message,
                                    _whatsController,
                                    teclado: TextInputType.phone,
                                  ),
                                ],
                              )
                                  : const SizedBox(),
                            ),

                            const SizedBox(height: 20),

                            // BOTÕES
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _modoCadastro
                                    ? Row(
                                  key: const ValueKey('cadastro'),
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: _salvarCadastroFake,
                                        style: _botaoStyle(Colors.blueAccent),
                                        child: _botaoTexto('Salvar'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: _sairCadastro,
                                        style: _botaoStyle(Colors.grey.shade400),
                                        child: _botaoTexto('Sair'),
                                      ),
                                    ),
                                  ],
                                )
                                    : ElevatedButton(
                                  key: const ValueKey('login'),
                                  onPressed: _acaoLoginFake,
                                  style: _botaoStyle(Colors.blueAccent),
                                  child: _botaoTexto('Entrar'),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            GestureDetector(
                              onTap: () => setState(() => _modoCadastro = true),
                              child: Text(
                                !_modoCadastro ? 'Cadastrar usuário' : '',
                                style: GoogleFonts.poppins(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),
                            _subText("www.engsoftmax.com.br"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _campo(
      String label,
      IconData icon,
      TextEditingController controller, {
        TextInputType teclado = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: teclado,
        decoration: _decoracao(label, icon),
      ),
    );
  }

  InputDecoration _decoracao(String label, IconData icon, {Widget? sufixo}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: sufixo,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle _botaoStyle(Color cor) {
    return ElevatedButton.styleFrom(
      backgroundColor: cor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _botaoTexto(String texto) {
    return Text(
      texto,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _subText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }
}

