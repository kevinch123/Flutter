import '../models/production.dart';

class ProductionController {
  int calculateProduction(Production production){
    double totalKg= production.meat +
                    production.protein+
                    production.fat+
                    production.flour+
                    production.onion+
                    production.water;
    return (totalKg/0.09).floor();
  }
  
}