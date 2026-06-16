import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/event_model.dart';
import '../services/pdf_service.dart';
import 'package:share_plus/share_plus.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  final Event event;

  const RegistrationSuccessScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Ticket"),
        backgroundColor: Colors.blue,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 20),

                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),

                const SizedBox(height: 10),

                const Text(
                  "Registration Successful",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(
                          event.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(event.date),
                        Text(event.location),
                        const SizedBox(height: 10),

Text(
  "Ticket ID: ${event.registrationId}",
  style: const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
),


                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: QrImageView(
                            data:
"${event.registrationId}-${event.title}",
                            size: 160,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Show this QR code at entrance",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Buttons
                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.all(14),
                        ),
                        icon: const Icon(Icons.download),
                        label: const Text("Download PDF"),
                        onPressed: () async {
  await PdfService.generateTicket(
    event,
  );
},
                      ),
                    ),
                   

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(14),
                        ),
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                        onPressed: () {
                           Share.share(
    '''
Event Ticket

${event.title}

Date: ${event.date}

Location: ${event.location}

Ticket ID: ${event.registrationId}
''',
  );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.workspace_premium),
    label: const Text(
      "Download Certificate",
    ),
    onPressed: () async {
      await PdfService.generateCertificate(
        event,
      );
    },
  ),
),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}