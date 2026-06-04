import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/helper.dart';
import 'package:quali_prevention_app/common/model/client_model.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_app_bar.dart';
import 'package:quali_prevention_app/services/user_service.dart';

class CommissionDetailPage extends StatefulWidget {
  const CommissionDetailPage({super.key});

  @override
  State<CommissionDetailPage> createState() => _CommissionDetailPageState();
}

class _CommissionDetailPageState extends State<CommissionDetailPage> {
  final UserService userService = UserService();
  late int clientId;
  String step = 'step_1';
  Client? client = Client(
    id: 0,
    firstName: '',
    lastName: '',
    createdAt: '',
    picture: '',
    statutName: '',
    domain: '',
    consomationAnuelle: '',
    commission: 0,
    projectAdvancement: 0,
    formation: '',
  );

  Future<void> _loadUserProfile() async {
    client = await userService.getClientById(clientId: clientId);
    if (client?.projectAdvancement == 0) step = 'step_1';
    if (client?.projectAdvancement == 25) step = 'step_2';
    if (client?.projectAdvancement == 50) step = 'step_3';
    if (client?.projectAdvancement == 75) step = 'step_4';
    if (client?.projectAdvancement == 100) step = 'step_5';
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>?;
    if (arguments != null) {
      clientId = arguments['clientId'] ?? 0;
      _loadUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: '${client?.firstName ?? ''} ${client?.lastName ?? ''}'),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 25, bottom: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff004357).withOpacity(0.10),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: const Offset(
                        0,
                        5,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        spacing: 20,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: null,
                            backgroundColor:
                                _statusColor(client?.statutName ?? ''),
                            radius: 25,
                            child: Text(
                              _initials(
                                client?.firstName ?? '',
                                client?.lastName ?? '',
                              ),
                              style: GoogleFonts.poppins(
                                color: white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${client?.firstName ?? ''} ${client?.lastName ?? ''}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: textPrimary,
                                ),
                              ),
                              Text(
                                client?.statutName ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: textBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffDCE5E7).withOpacity(0.5),
                            white.withOpacity(0.5)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text.rich(
                            style: TextStyle(
                              color: textBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Code Client: '),
                                TextSpan(text: client?.id.toString() ?? ''),
                              ],
                            ),
                          ),
                          Divider(
                            height: 30,
                            color: grey,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/installation.svg',
                                height: 20,
                              ),
                              Text.rich(
                                style: const TextStyle(
                                  color: Color(0xff434343),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                TextSpan(
                                  children: [
                                    const TextSpan(text: 'Montant : '),
                                    TextSpan(
                                      text: client!.montant == null
                                          ? ''
                                          : formatCurrency(
                                              double.parse(client!.montant!),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (_showsUpcomingCommission(client)) ...[
                            const SizedBox(height: 6),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 6,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/installation.svg',
                                  height: 20,
                                ),
                                Text.rich(
                                  style: const TextStyle(
                                  color: Color(0xff434343),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                  TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: 'Commissions à venir : '),
                                    TextSpan(
                                      text: client!.commission == null
                                          ? ''
                                          : formatCurrency(
                                              client!.commission!.toDouble()),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ],
                          Divider(
                            height: 30,
                            color: grey,
                          ),
                          const Text(
                            'Date de versement prévue ',
                            style: TextStyle(
                              color: Color(0xff727576),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            client!.estimatedPaymentDate == null
                                ? 'Non définie'
                                : formatDateTime(
                                    client!.estimatedPaymentDate!,
                                  ),
                            style: TextStyle(
                              color: textBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text.rich(
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Avancée du projet : '),
                                TextSpan(
                                    text: '${client?.projectAdvancement}%',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          SvgPicture.asset(
                            'assets/svg/steps/$step.svg',
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    final normalized = status.toLowerCase();

    if (normalized.contains('prospect')) {
      return darkGrey;
    }

    if (normalized.contains('signé') || normalized.contains('signe')) {
      return const Color(0xFF2F52A9);
    }

    if (normalized.contains('en cours')) {
      return const Color(0xFFF99B0C);
    }

    if (normalized.contains('déposé') || normalized.contains('depose')) {
      return const Color(0xFF7BC87C);
    }

    if (normalized.contains('payé') || normalized.contains('paye')) {
      return const Color(0xFF2E7D32);
    }

    if (normalized.contains('clos') ||
        normalized.contains('abandon') ||
        normalized.contains('refus') ||
        normalized.contains('annul') ||
        normalized.contains('non éligible') ||
        normalized.contains('non-eligible')) {
      return const Color(0xFFDC3545);
    }

    return grey;
  }

  bool _showsUpcomingCommission(Client? client) {
    if (client == null || client.commission == null) {
      return false;
    }

    return client.commission!.toDouble() > 0;
  }

  String _initials(String firstName, String lastName) {
    final first =
        firstName.trim().isNotEmpty ? firstName.trim().characters.first : '';
    final last =
        lastName.trim().isNotEmpty ? lastName.trim().characters.first : '';
    final initials = '$first$last'.trim();
    return initials.isEmpty ? '?' : initials.toUpperCase();
  }
}
