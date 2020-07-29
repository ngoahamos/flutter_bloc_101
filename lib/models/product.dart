class Product {
  static String NAME_KEY = 'name';
  String id;
  String name;
  num amount;

  Product.create(this.name);

  Product.fromFirebase(Map<String, dynamic> json) {
    this.name = json[NAME_KEY];
  }

  @override
  bool operator == (o) => o is Product && o.name == name && o.id == id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}