class Author{
  int ID;
  String nom;
  String prenom;

  Author(this.ID, this.nom, this.prenom);

  Map<String, dynamic> toMap() {
    return {
      'id' : ID,
      'nom' : nom,
      'prenom' : prenom
    };
  }
}