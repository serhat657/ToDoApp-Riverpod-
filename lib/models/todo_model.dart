class TodoModel{
  late final String id;
  late final String description;
  late final bool completed;
  
  TodoModel({required this.id, required this.description,  this.completed =false});
}