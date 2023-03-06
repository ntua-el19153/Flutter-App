import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'events.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'dart:core';
import 'package:path_provider/path_provider.dart';

/// Υλοποίηση της οθόνης ViewEditTask ως [StatefulWidget]
class AddWidget extends StatefulWidget {
  const AddWidget({Key? key}) : super(key: key);

  @override
  _AddWidgetState createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  /// Μεταβλητή που μας επιτρέπει να κάνουμε επικύρωση των δεδομένων που έχουν
  /// εισαχθεί στη φόρμα προσθήκης νέου task
  AudioPlayer player = AudioPlayer();
  final _formKey = GlobalKey<FormState>();

  /// Αρχικοποίηση μεταβλητών controller για την λήψη των δεδομένων που
  /// έχουν εισαχθεί στο πεδίο του τίτλου και της περιγραφής του task
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  /// Μεταβλητή που κρατάει την ώρα του alarm του task. Επειδή δεν είναι υποχρε-
  /// ωτικό το task να έχει alarm, η μεταβλητή αυτή μπορεί να είναι και null
  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime.now();
  bool datepicked = false;
  bool timepicked = false;

  /// Boolean flag η οποία εμφανίζει το [Widget] διαγραφής alarm όταν είναι true
  bool _visibletime = false;
  bool _visibledate = false;

  /// Εμφάνιση του παραθύρου επιλογής ώρας alarm. Γdια περισσότερες πληροφορίες
  /// σχετικές με date/time pickers ανατρέξτε στο documentation
  /// https://m3.material.io/components/time-pickers/overview
  void _showtime() async {
    /// Εμφάνιση του time picker [showTimePicker] και αποθήκευση του αποτελέσμα-
    /// τος στην μεταβλητή [result] (τύπου [TimeOfDay]). Καθώς ο χρήστης μπορεί
    /// να πατήσει cancel, η μεταβλητή αυτή μπορεί να γίνει και null
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 230, 201, 235), // <-- SEE HERE
              onPrimary: Colors.pink, // <-- SEE HERE
              onSurface: Colors.grey, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary:
                    Color.fromARGB(255, 219, 161, 229), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    /// Στην περίπτωση που ο χρήστης έχει επιλέξει ώρα alarm, ενημέρωσε την
    /// κατάσταση του [Widget], θέτοντας την ώρα στη μεταβλητή [_alarmTime]
    /// και θέτοντας το boolean flag [_visibleAlarmTime] σε true
    if (result != null) {
      setState(() {
        _time = result;
        _visibletime = true;
      });
    }
  }

  void _showdate() async {
    /// Εμφάνιση του time picker [showTimePicker] και αποθήκευση του αποτελέσμα-
    /// τος στην μεταβλητή [result] (τύπου [TimeOfDay]). Καθώς ο χρήστης μπορεί
    /// να πατήσει cancel, η μεταβλητή αυτή μπορεί να γίνει και null
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023, 1),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 230, 201, 235), // <-- SEE HERE
              onPrimary: Colors.pink, // <-- SEE HERE
              onSurface: Colors.grey, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary:
                    Color.fromARGB(255, 219, 161, 229), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    /// Στην περίπτωση που ο χρήστης έχει επιλέξει ώρα alarm, ενημέρωσε την
    /// κατάσταση του [Widget], θέτοντας την ώρα στη μεταβλητή [_alarmTime]
    /// και θέτοντας το boolean flag [_visibleAlarmTime] σε true
    if (result != null) {
      setState(() {
        _date = result;
        _visibledate = true;
      });
    }
  }

  /// Καταστροφή στιγμιοτύπου κλάσης
  @override
  void dispose() {
    /// Απελευθέρωση των πόρων που δέσμευσαν οι [TextEditingController]
    _titleController.dispose();
    _descriptionController.dispose();

    /// Τέλος, καλούμε την dispose της υπερκλάσης
    super.dispose();
  }

  /// Μέθοδος που κατασκευάζει το [Widget] της προσθήκης νέου task
  @override
  Widget build(BuildContext context) {
    /// Επιστρέφουμε περιβάλλον [Scaffold]
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 230, 201, 235),
        title: const Text('Create Event'),
      ),

      /// Έχουμε μια φόρμα ([Form]) από στοιχεία
      body: Form(
        /// To κλειδί της φόρμας για την επικύρωση των δεδομένων της
        key: _formKey,

        /// Στη φόρμα έχουμε μια στήλη ([Column]) από στοιχεία
        child: Column(
          ///  Στοίχιση πάνω αριστερά στο [body] του [Scaffold]
          crossAxisAlignment: CrossAxisAlignment.start,

          /// Λίστα με τα στοιχεία ([Widget]) της στήλης
          children: <Widget>[
            /// Προσθήκη "γεμίσματος" γύρω από τα στοιχεία της φόρμας, έτσι ώστε
            /// να μην "κολλάνε" το ένα με το άλλο, μέσω της χρήσης του [Widget]
            /// [Padding]
            Padding(

                /// Καθορισμός "γεμίσματος" 8 pixel και τις 4 κατευθύνσεις (πάνω,
                /// κάτω, δεξιά, αριστερά), χρησιμοποιώντας την κλάση [EdgeInsets]
                padding: const EdgeInsets.all(8.0),

                /// Πεδίο εισαγωγής κειμένου μιας γραμμής ([TextFormField]) για
                /// τον τίτλο του νέου task
                child: TextFormField(
                  /// Εμφάνιση πληροφοριών για το όνομα του συγκερκιμένου πεδίου
                  /// μέσω της χρήσης της κλάσης [InputDecoration]
                  decoration: const InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(borderSide: BorderSide())),

                  /// Σύνδεση με τον αντίστοιχο [TextEditingController] για τη
                  /// λήψη των δεδομένων που έχει πληκτρολογίσει ο χρήστης στο
                  /// εν λόγω πεδίο
                  controller: _titleController,

                  /// Επικύρωση φόρμας. Αν ο χρήστης δεν έχει δώσει τίτλο, μην
                  /// επιτρέψεις την υποβολή της φόρμας, εμφανίζοντας σχετικό
                  /// μήνυμα σφάλματος γύρω από το συγκεκριμένο πεδίο
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty!';
                    }
                    return null;
                  },
                )),
            Padding(

                /// Καθορισμός "γεμίσματος" 8 pixel και τις 4 κατευθύνσεις (πάνω,
                /// κάτω, δεξιά, αριστερά), χρησιμοποιώντας την κλάση [EdgeInsets]
                padding: const EdgeInsets.all(8.0),

                /// Πεδίο εισαγωγής κειμένου μιας γραμμής ([TextFormField]) για
                /// τον τίτλο του νέου task
                child: TextFormField(
                  /// Εμφάνιση πληροφοριών για το όνομα του συγκερκιμένου πεδίου
                  /// μέσω της χρήσης της κλάσης [InputDecoration]
                  decoration: const InputDecoration(
                      hintText: 'Location',
                      border: OutlineInputBorder(borderSide: BorderSide())),

                  /// Σύνδεση με τον αντίστοιχο [TextEditingController] για τη
                  /// λήψη των δεδομένων που έχει πληκτρολογίσει ο χρήστης στο
                  /// εν λόγω πεδίο
                  controller: _locationController,

                  /// Επικύρωση φόρμας. Αν ο χρήστης δεν έχει δώσει τίτλο, μην
                  /// επιτρέψεις την υποβολή της φόρμας, εμφανίζοντας σχετικό
                  /// μήνυμα σφάλματος γύρω από το συγκεκριμένο πεδίο
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location cannot be empty!';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),

                /// Χρήστη [TextField] [Widget] για την είσοδο κειμένου πολλα-
                /// πλών γραμμών.
                child: TextField(
                  minLines: 10,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(borderSide: BorderSide())),

                  /// Σύνδεση με τον αντίστοιχο [TextEditingController]. Σε αυτή
                  /// την περίπτωση δεν έχουμε input validation, μιας και το πε-
                  /// δίο της περιγραφής του task μπορεί να είναι κενό
                  controller: _descriptionController,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),

                /// Το τελευταίο στοιχείο της στήλης των στοιχείων είναι ένα
                /// στοιχείο γραμμής ([Row]), που περιέχει τα εικονίδια της
                /// επιλογής και ακύρωσης επιλογής alarm, καθώς και των κουμπιών
                /// της ακύρωσης και της καταχώρησης του task
                child: Row(
                  children: <Widget>[
                    /// Εικονίδιο προσθήκης alarm. Όταν πατηθεί καλεί τη συνάρ-
                    /// τηση _show για την εμφάνιση του Time picker
                    IconButton(
                      onPressed: _showtime,
                      icon: Icon(Icons.lock_clock),
                      tooltip: 'Add time',
                    ),

                    /// Στοιχείο [Visibility] που εμφανίζει στοιχείο [Text] όταν
                    /// το boolean flag [_visibleAlarmTime] είναι αληθές, δηλαδή
                    /// όταν ο χρήστης έχει προσθέσει alarm.
                    Visibility(
                        visible: _visibletime,
                        child:
                            Text(_time != null ? _time!.format(context) : '')),
                    IconButton(
                      onPressed: _showdate,
                      icon: Icon(Icons.calendar_month),
                      tooltip: 'Add date',
                    ),

                    /// Στοιχείο [Visibility] που εμφανίζει στοιχείο [Text] όταν
                    /// το boolean flag [_visibleAlarmTime] είναι αληθές, δηλαδή
                    /// όταν ο χρήστης έχει προσθέσει alarm.
                    Visibility(
                        visible: _visibledate,
                        child: Text(_date != null
                            ? '${_date.day}/${_date.month}/${_date.year}'
                            : '')),

                    /// Στοιχείο [Visibility] που εμφανίζει εικονίδιο ακύρωσης
                    /// alarm όταν το boolean flag [_visibleAlarmTime] είναι
                    /// αληθές, δηλαδή όταν ο χρήστης έχει προσθέσει alarm. Όταν
                    /// πατηθεί, αλλάζει την κατάσταση του [Widget], σβήνοντας
                    /// το alarm του χρήστη και κάνοντας το boolean flag
                    /// [_visibleAlarmTime] ψευδές. Έτσι, αυτό και το προηγούμενο
                    /// στοιχείο θα πάψουν να είναι ορατά.
                    /*Visibility(
                        visible: _visibleAlarmTime,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                // _alarmTime = null;
                                _visibleAlarmTime = false;
                              });
                            },
                            icon: const Icon(Icons.cancel))),*/

                    /// Στοιχείο [Flexible] που μας επιτρέπει να στοιχίσουμε τα
                    /// δύο τελευταία κουμπιά δεξιά στη γραμμή
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),

                    /// Κουμπί [ElevatedButton] ακύρωσης. Επειδή σε αυτή την
                    /// οθόνη (ViewEditTask) έχουμε έρθει μέσω Navigator.push()
                    /// από την TaskListScreen, θα επιστέψουμε με Navigator.pop()
                    /// για να μην υπερχειλίσουμε τη στοίβα.
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Color.fromARGB(255, 230, 201, 235)),
                          )),
                    ),

                    /// Κουμπί [ElevatedButton] υποβολής νέου task
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            /// Αρχικά ελέγχουμε αν τα στοιχεία της φόρμας
                            /// "παιρνούν" την επικύρωση (αν ο τίτλος δεν είναι
                            /// κενός)
                            if (_formKey.currentState!.validate()) {
                              if (_visibledate && _visibletime) {
                                String audioUrl = 'assets/audios/applause.mp3';
                                final ByteData data =
                                    await rootBundle.load(audioUrl);
                                // final Directory tempDir = Directory.systemTemp;
                                final Directory tempDir =
                                    await getTemporaryDirectory();
                                final File file =
                                    File('${tempDir.path}/audio1.mp3');
                                await file.writeAsBytes(
                                    data.buffer.asUint8List(),
                                    flush: true);
                                player.play(file.path, isLocal: true);

                                /// Αν ναι, δημιουργώ ένα νέο [Task] από τα στοι-
                                /// χεία της φόρμας
                                final task = Event(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  location: _locationController.text,
                                  time: _time,
                                  personal: true,
                                  date: _date,
                                );

                                /// Όπως και στην περίπτωση της ακύρωσης, επιστρέφω
                                /// το νέο [task] στην TaskListScreen μέσω
                                /// Navigator.pop() για να μην υπερχειλίσω τη
                                /// στοίβα
                                Navigator.pop(context, task);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Date & Time'),
                                      content: Text(
                                          'Please enter the date & time of the event.'),
                                      actions: [
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 230, 201, 235)),
                                          ),
                                          child: Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 230, 201, 235)),
                          ),
                          child: const Text('Save'),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
