package luokat;

public class Toimitusosoite {
	
	private String katuosoite;
	private int postinro;
	private String postitmp;
	

	private Toimitusosoite (String katuosoite, int postinro, String postitmp ){
		this.katuosoite=katuosoite;
		this.postinro=postinro;
		this.postitmp=postitmp;

}


		
	
	public String getKatuosoite() {
		return katuosoite;
	}


	public void setKatuosoite(String katuosoite) {
		this.katuosoite = katuosoite;
	}


	public int getPostinro() {
		return postinro;
	}


	public void setPostinro(int postinro) {
		this.postinro = postinro;
	}


	public String getPostitmp() {
		return postitmp;
	}}
