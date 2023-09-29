enum Status {
  pending,
  completed,
}


class Meal02 {
 
  Status status; // เพิ่มฟิลด์ status ใหม่

  Meal02({
 
    required this.status, // เพิ่มการรับค่า status ใหม่
  });
}