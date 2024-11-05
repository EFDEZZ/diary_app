class ElectronicMedicalRecord {
  final int ci;
  final String patientName;
  final DateTime dateOfBirth;
  final String gender;
  final String chronicDiseases;
  final String allergies;
  final String currentMedications;
  final String consultations;
  final String labResults;
  final String hospitalizations;

  ElectronicMedicalRecord({
    required this.ci,
    required this.patientName,
    required this.dateOfBirth,
    required this.gender,
    required this.chronicDiseases,
    required this.allergies,
    required this.currentMedications,
    required this.consultations,
    required this.labResults,
    required this.hospitalizations
  });
}
