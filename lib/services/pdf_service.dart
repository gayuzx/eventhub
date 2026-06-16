
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/event_model.dart';

class PdfService {
  static Future<void> generateTicket(
    Event event,
  ) async {
    final pdf = pw.Document();
    

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              pw.Text(
                "EventHub Ticket",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Event: ${event.title}",
              ),

              pw.Text(
                "Date: ${event.date}",
              ),

              pw.Text(
                "Location: ${event.location}",
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Registration Confirmed ✅",
              ),
            ],
          );
        },
      ),
    );
    
  await Printing.layoutPdf(
    onLayout: (format) async =>
        pdf.save(),
  );


  }  
  static Future<void>
generateCertificate(
  Event event,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment:
                pw.MainAxisAlignment.center,
            children: [

              pw.Text(
                "CERTIFICATE OF PARTICIPATION",
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight:
                      pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 40),

              pw.Text(
                "This certifies that",
                style:
                    const pw.TextStyle(
                  fontSize: 18,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Gayathri",
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight:
                      pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "has successfully participated in",
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                event.title,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight:
                      pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 40),

              pw.Text(
                "Event Date: ${event.date}",
              ),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async =>
        pdf.save(),
  );
}

}