INSERT INTO public."Codes" ("Id","SubmissionId","FileName","Content","CreatedAt","IsEnabled","UpdatedAt") VALUES
	 ('29198014-716f-4601-9fa4-bd1c8438b389','6e701991-2a14-4493-a170-f4fe910e9c4a','Calculadora.java','package com.example;

public class Calculadora {
public static double dividir(int numerador, int denominador) throws DivisionPorCeroException {
if (denominador == 0) {
throw new DivisionPorCeroException("Error: División por cero no permitida.");
}
return (double) numerador / denominador;
}

public static void main(String[] args) {
try {
System.out.println("Resultado: " + dividir(10, 0));
} catch (DivisionPorCeroException e) {
System.err.println(e.getMessage());
}
}
}

','-infinity',false,'-infinity'),
	 ('b3cff7d1-c24d-4814-a541-aa0c5c435a03','6e701991-2a14-4493-a170-f4fe910e9c4a','DivisionPorCeroException.java','

















package com.example;

public class DivisionPorCeroException extends Exception {
public DivisionPorCeroException(String mensaje) {
super(mensaje);
}
}
','-infinity',false,'-infinity'),
	 ('e3f3df6d-866b-47a0-9ba8-57a34456a1db','6e701991-2a14-4493-a170-f4fe910e9c4a','Main.java','

























package com.example;

class Main {

public static void main(String[] args) {

System.out.println("Hello World!");
}
}','-infinity',false,'-infinity'),
	 ('4abb984e-aead-4b40-88b0-8c801fdde54c','31edb16a-feb4-4cab-812c-e8a4bdb6ad45','HelloCodiva.java','
package com.example;

class HelloCodiva {
public static void main(String[] args) {
int a = 15;
int b = 20; // will generate an error
int c = 654;
System.out.println(a+b+c);
}
}
','-infinity',false,'-infinity'),
	 ('5c96bfec-28ba-4c23-b9da-fbf4cf835e0d','31edb16a-feb4-4cab-812c-e8a4bdb6ad45','Main.java','










package com.example;

public class Main {
public static void main(String[] args) {
int myNum = 5;               // integer (whole number)
float myFloatNum = 5.99f;    // floating point number
char myLetter = ''D'';         // character
boolean myBool = true;       // boolean
String myText = "Hello";     // String
System.out.println(myNum);
System.out.println(myFloatNum);
System.out.println(myLetter);
System.out.println(myBool);
System.out.println(myText);
}
}','-infinity',false,'-infinity'),
	 ('301e8585-ac92-4bd2-809b-262228bcc1c1','e0d30fd2-1027-4af3-be3b-238a579dacb8','HelloCodiva.java','package com.example;

class HelloCodiva {

public static void main(String[] args) {

String greeting = "Hello World";
System.out.println(greeting);

}
}
','-infinity',false,'-infinity'),
	 ('32914a3b-9b54-4e6b-ad27-033693f8e181','e0d30fd2-1027-4af3-be3b-238a579dacb8','Main.java','










package com.example;

class Main {
public static void main(String[] args) {
char myLetter = ''D'';         // character
boolean myBool = true;       // boolean
String myText = "Hello";     // String

int myNum = 5;
float myFloatNum = 5.99f;

System.out.println(myNum);
System.out.println(myFloatNum);
System.out.println(myLetter);
System.out.println(myBool);
System.out.println(myText);
}
}','-infinity',false,'-infinity'),
	 ('114d5b4c-dc7d-4236-8a25-3ea837565ccb','b6c2d5e1-33c4-4048-820b-03d25fe674b9','Diccionario.java','
























import java.util.HashMap;

public class Diccionario {
public static void main(String[] args) {
// Crear un HashMap para almacenar palabras y sus definiciones
HashMap<String, String> diccionario = new HashMap<>();

// Añadir elementos al diccionario
diccionario.put("Java", "Lenguaje de programación orientado a objetos.");
diccionario.put("Python", "Lenguaje de programación de alto nivel.");
diccionario.put("HTML", "Lenguaje de marcado para crear páginas web.");

// Buscar y mostrar una definición
String palabra = "Java";
if (diccionario.containsKey(palabra)) {
System.out.println(palabra + ": " + diccionario.get(palabra));
} else {
System.out.println("Palabra no encontrada en el diccionario.");
}

// Mostrar todas las palabras en el diccionario
System.out.println("\nPalabras en el diccionario:");
for (String key : diccionario.keySet()) {
System.out.println(key + ": " + diccionario.get(key));
}
}
}



','-infinity',false,'-infinity'),
	 ('6086a89a-4585-4fe3-9e27-eaa3d95aa880','b6c2d5e1-33c4-4048-820b-03d25fe674b9','asf.java','













































































































class asf {
public static void main(String[] args) {

System.out.println("Hello Codiva");

}
}

','-infinity',false,'-infinity'),
	 ('840757b3-4bf7-45ed-9f7c-fc5611f4fba2','b6c2d5e1-33c4-4048-820b-03d25fe674b9','FileHandler.java','



















































import java.io.*;

public class FileHandler {
public static void main(String[] args) {
String fileName = "example.txt";

// Escribir en un archivo
try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {
writer.write("Este es un ejemplo de escritura en archivo.");
writer.newLine();
writer.write("Java es genial para manejar archivos.");
System.out.println("Escritura en archivo completada.");
} catch (IOException e) {
System.err.println("Error al escribir en el archivo: " + e.getMessage());
}

// Leer desde un archivo
try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
String line;
while ((line = reader.readLine()) != null) {
System.out.println("Contenido del archivo: " + line);
}
} catch (IOException e) {
System.err.println("Error al leer el archivo: " + e.getMessage());
}
}
}



','-infinity',false,'-infinity');
INSERT INTO public."Codes" ("Id","SubmissionId","FileName","Content","CreatedAt","IsEnabled","UpdatedAt") VALUES
	 ('8de526ca-eba8-4411-980c-c4f777032172','b6c2d5e1-33c4-4048-820b-03d25fe674b9','TestAnimales.java','















































































class Animal {
public void sonido() {
System.out.println("El animal hace un sonido");
}
}

class Perro extends Animal {
@Override
public void sonido() {
System.out.println("El perro ladra");
}
}

class Gato extends Animal {
@Override
public void sonido() {
System.out.println("El gato maúlla");
}
}

public class TestAnimales {
public static void main(String[] args) {
Animal miPerro = new Perro();
Animal miGato = new Gato();

miPerro.sonido();
miGato.sonido();
}
}


','-infinity',false,'-infinity'),
	 ('a6f6fc1d-a887-475e-9abf-1db2c8e6bb52','b6c2d5e1-33c4-4048-820b-03d25fe674b9','Calculadora.java','class DivisionPorCeroException extends Exception {
public DivisionPorCeroException(String mensaje) {
super(mensaje);
}
}

public class Calculadora {
public static double dividir(int numerador, int denominador) throws DivisionPorCeroException {
if (denominador == 0) {
throw new DivisionPorCeroException("Error: División por cero no permitida.");
}
return (double) numerador / denominador;
}

public static void main(String[] args) {
try {
System.out.println("Resultado: " + dividir(10, 0));
} catch (DivisionPorCeroException e) {
System.err.println(e.getMessage());
}
}
}






','-infinity',false,'-infinity'),
	 ('fbfa56bc-81f8-49cf-81fc-80847ba2d664','b6c2d5e1-33c4-4048-820b-03d25fe674b9','asfsadasd.java','






















































































































class asfsadasd {
public static void main(String[] args) {

System.out.println("Hello Codiva");

}
}
','-infinity',false,'-infinity');
