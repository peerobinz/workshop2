
enum Status {
  pending,
  completed, //สถานะ
}



class Meal {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  int quantity; // เพิ่มฟิลด์ quantity
  String instructions;
  

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    this.quantity = 0,
    required this.instructions, // กำหนดค่าเริ่มต้นของ quantity เป็น 0
    
    
    
  });

  set status(Status status) {}
}


