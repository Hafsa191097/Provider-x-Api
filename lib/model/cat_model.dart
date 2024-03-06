class Cat_Model{
   String? name;
   String? image;
   bool? is_friendly;
   String? breed;
   String? id;

  Cat_Model({required this.name, required this.image, required this.is_friendly, required this.breed, required this.id});

  Cat_Model.fromJson(Map<String, dynamic> json){
    name = json['name'];
    image = json['image'];
    is_friendly = json['is_friendly'];
    breed = json['breed'];
    id = json['id'];
  }

}