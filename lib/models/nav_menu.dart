class NavMenuItem{

  String title;
  // Function reduce usage of resources
  // peter thane use Widget it will create object in every time call the constructor
  // but this way only return the Class but not create the object
  // the object created only for the item which we clicked on
  Function destination;

  NavMenuItem(this.title, this.destination);
}