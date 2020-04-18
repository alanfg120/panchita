

class Ciudad {
  String ciudad;
  String ruta;

  Ciudad({this.ciudad, this.ruta});

  Ciudad.map(Map<String,dynamic> map) {
    ciudad = map['ciudad'] ?? '';
    ruta = map['ruta']     ?? '';
  }
  Map toMap()=>{
   "ciudad": ciudad ?? '',
   "ruta"  : ruta   ?? ''
  };
}
