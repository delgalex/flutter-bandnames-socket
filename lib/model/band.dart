
class Band{
  
  String id;
  String name;
  int votes;

  Band({
    required this.id,
    required this.name,
    required this.votes
  });

  // el factory es un constructor que recibe argumentos y regresa una instancia de la clase

  factory Band.fromMap( Map<String, dynamic> obj ) 
    => Band(
      id: obj['id'],
      name: obj['name'],
      votes: obj['votes']
  );
  
}