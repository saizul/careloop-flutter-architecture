enum AppRoute {
  bootstrap('/'),
  patientShell('/patient'),
  doctorShell('/doctor'),
  adminShell('/admin');

  const AppRoute(this.path);

  final String path;
}
