void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  
  
  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!  
  String message = new String( data );
  
  // print the result
  println( "receive: \""+message+"\" from "+ip+" on port "+port );
}
