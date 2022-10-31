package br.com.SpringPaulistao.model;

public class AttResultado {

	private int codigoJogo;
	private int golsTimeA;
	private int golsTimeB;

	public AttResultado(int codigoJogo, int golsTimeA, int golsTimeB) {
		super();
		this.codigoJogo = codigoJogo;
		this.golsTimeA = golsTimeA;
		this.golsTimeB = golsTimeB;
	}
	
	public AttResultado() {
		
	}

	public int getCodigoJogo() {
		return codigoJogo;
	}

	public void setCodigoJogo(int codigoJogo) {
		this.codigoJogo = codigoJogo;
	}

	public int getGolsTimeA() {
		return golsTimeA;
	}

	public void setGolsTimeA(int golsTimeA) {
		this.golsTimeA = golsTimeA;
	}

	public int getGolsTimeB() {
		return golsTimeB;
	}

	public void setGolsTimeB(int golsTimeB) {
		this.golsTimeB = golsTimeB;
	}
	
	public static AttResultado deepCopy(AttResultado that) {
		AttResultado att = new AttResultado(that.codigoJogo, that.golsTimeA, that.golsTimeB);
		return att;
	}

	@Override
	public String toString() {
		return "AttResultado [codigoJogo=" + codigoJogo + ", golsTimeA=" + golsTimeA + ", golsTimeB=" + golsTimeB + "]";
	}

}
