class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final double price; // เพิ่ม field สำหรับราคา
  final String category;
  final String description;
  int quantity; 
  // ตัด field instructions และ category ออกถ้าไม่มีใน API ใหม่

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price, // เพิ่มตัวแปรนี้
    required this.category,
    required this.description,
    this.quantity = 0,
  });
}
