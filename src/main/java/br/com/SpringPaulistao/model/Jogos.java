package br.com.SpringPaulistao.model;

public class Jogos {

	private int codigoJogo;
	private int codigoTimeA;
	private int codigoTimeB;
	private String nomeTimeA;
	private String nomeTimeB;
	private int golsTimeA;
	private int golsTimeB;
	private String data;

	public int getCodigoJogo() {
		return codigoJogo;
	}

	public void setCodigoJogo(int codigoJogo) {
		this.codigoJogo = codigoJogo;
	}

	public String getNomeTimeA() {
		return nomeTimeA;
	}

	public void setNomeTimeA(String nomeTimeA) {
		this.nomeTimeA = nomeTimeA;
	}

	public String getNomeTimeB() {
		return nomeTimeB;
	}

	public void setNomeTimeB(String nomeTimeB) {
		this.nomeTimeB = nomeTimeB;
	}

	public int getCodigoTimeA() {
		return codigoTimeA;
	}

	public void setCodigoTimeA(int codigoTimeA) {
		this.codigoTimeA = codigoTimeA;
	}

	public int getCodigoTimeB() {
		return codigoTimeB;
	}

	public void setCodigoTimeB(int codigoTimeB) {
		this.codigoTimeB = codigoTimeB;
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

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "Jogos [codigoJogo=" + codigoJogo + ", codigoTimeA=" + codigoTimeA + ", codigoTimeB=" + codigoTimeB
				+ ", nomeTimeA=" + nomeTimeA + ", nomeTimeB=" + nomeTimeB + ", golsTimeA=" + golsTimeA + ", golsTimeB="
				+ golsTimeB + ", data=" + data + "]";
	}

}
