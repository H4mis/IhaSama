package dao;

import java.util.*;


import luokat.TilattuPizza;
import luokat.Tilaus;

public class KoriDAO {

	public List<TilattuPizza> PoistaKorista (int poisto, List<TilattuPizza> kori){
		
		kori.remove(poisto);
		
		return kori;	
		
	}
	
	
	public List<TilattuPizza> lisaaKoriin(TilattuPizza tp, List<TilattuPizza> kori){		
		
		kori.add(tp);
		
		
		return kori;
	}
	
}
