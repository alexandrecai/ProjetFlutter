class Categorie{
  int ID;
  String libelle;

  Categorie(this.ID,this.libelle);

  @override
  String toString() {
    return 'Categorie{ID: $ID, libelle: $libelle}';
  }
}