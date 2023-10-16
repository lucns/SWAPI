class AppUser {
  int id;
  String name = "";
  String cpf = "";
  String password = "";
  bool isActive;

  AppUser(this.name, this.cpf, this.password,
      {this.id = 0, this.isActive = false});
}
