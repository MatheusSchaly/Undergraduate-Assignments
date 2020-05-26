public class Generics_Summary {
	
	public static void main(String[] args) {
		// Int_Box can have int as data:
		Int_Box int_box = new Int_Box();
		int_box.set(10);
		// But can't have anything else:
		// int_box.set("Schaly"); error: it expects an int
		
		
		// Object_Box can have int as data:
		Object_Box object_box = new Object_Box();
		object_box.set(10);
		// And can have any other Object as data:
		object_box.set("Schaly");
		
		// But it needs casting to retrieve the data:
		// int my_int = object_box.get(); // error: expects casting to int
		
		// And doesn't have type-checking at compile time. May cause ClassCastException:
		// int my_int = (int) object_box.get(); // possible but causes ClassCastException		
		
		
		// Generic_Box can have int as data:
		Generic_Box<Integer> integer_box = new Generic_Box<>();
		integer_box.set(10);
		// Can have any other Object as data:
		Generic_Box<String> string_box = new Generic_Box<>();
		string_box.set("String");
		
		// Doesn't need casting to retrieve the data:
		String name = string_box.get();
		
		// And have type-checking at compile time:
		// int an_int = string_box.get(); // error: get() returns a String for sure
	}
}

// Not generic
class Int_Box {
	private int data;
	public Int_Box() {}
	public void set(int data) {this.data = data;}
	public int get() {return data;}
}

// Generic, but needs casting and can cause run time exception
class Object_Box {
	private Object data;
	public void set(Object data) {this.data = data;}
	public Object get() {return data;}
}

// Real generics, doesn't need casting and can cause compile time error
class Generic_Box<T> {
	private T data;
	public void set(T data) {this.data = data;}
	public T get() {return data;}
}