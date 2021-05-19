public class Item{
  int conditionID;
  PVector position;
  PImage image;
  int id;
  String text;
  public Item(int conditionID, JSONObject it){
    this.conditionID = conditionID;
    position = new PVector(0,0);
    this.id = it.getInt("id");
    this.text = it.getString("text");
    this.image = loadImage("./data/items/"+(it.getInt("imageID")+".png"));
    System.out.println("Image Loaded");
  }
  @Override
  public boolean equals(Object o){
    if(o==this) return true;
    if(!(o instanceof Item)) return false;
    Item i = (Item)o;
    if(i.id == this.id) return true;
    return false;
  }
}  
