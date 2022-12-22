class Historique {
 final String Plant_Id;
 int Number_Watering = 0;
 DateTime Date_Arro=DateTime.now();
 late double Temp;
 late double Hum;
 Historique(this.Plant_Id,this.Temp,this.Hum);

 void updateHisDateArro(DateTime dd){
   this.Date_Arro=dd;
 }
 void updateNbArro(){
  this.Number_Watering++;
 }
 void updateHisTempHum(double t, double h){
  this.Temp=t;
  this.Hum=h;
 }
}