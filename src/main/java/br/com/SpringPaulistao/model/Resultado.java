package br.com.joaosantana.SpringPaulistao.model;

public class Resultado {

	private String nomeTime;
	private int numeroJogosDisputados;
	private int vitorias;
	private int empates;
	private int derrotas;
	private int golsMarcados;
	private int golsSofridos;
	private int saldoGols;
	private int pontos;

	public String getNomeTime() {
		return nomeTime;
	}

	public void setNomeTime(String nomeTime) {
		this.nomeTime = nomeTime;
	}

	public int getNumeroJogosDisputados() {
		return numeroJogosDisputados;
	}

	public void setNumeroJogosDisputados(int numeroJogosDisputados) {
		this.numeroJogosDisputados = numeroJogosDisputados;
	}

	public int getVitorias() {
		return vitorias;
	}

	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}

	public int getEmpates() {
		return empates;
	}

	public void setEmpates(int empates) {
		this.empates = empates;
	}

	public int getDerrotas() {
		return derrotas;
	}

	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}

	public int getGolsMarcados() {
		return golsMarcados;
	}

	public void setGolsMarcados(int golsMarcados) {
		this.golsMarcados = golsMarcados;
	}

	public int getGolsSofridos() {
		return golsSofridos;
	}

	public void setGolsSofridos(int golsSofridos) {
		this.golsSofridos = golsSofridos;
	}

	public int getSaldoGols() {
		return saldoGols;
	}

	public void setSaldoGols(int saldoGols) {
		this.saldoGols = saldoGols;
	}

	public int getPontos() {
		return pontos;
	}

	public void setPontos(int pontos) {
		this.pontos = pontos;
	}

	@Override
	public String toString() {
		return "Resultado [nomeTime=" + nomeTime + ", numeroJogosDisputados=" + numeroJogosDisputados + ", vitorias="
				+ vitorias + ", empates=" + empates + ", derrotas=" + derrotas + ", golsMarcados=" + golsMarcados
				+ ", golsSofridos=" + golsSofridos + ", saldoGols=" + saldoGols + ", pontos=" + pontos
				+ ", getNomeTime()=" + getNomeTime() + ", getNumeroJogosDisputados()=" + getNumeroJogosDisputados()
				+ ", getVitorias()=" + getVitorias() + ", getEmpates()=" + getEmpates() + ", getDerrotas()="
				+ getDerrotas() + ", getGolsMarcados()=" + getGolsMarcados() + ", getGolsSofridos()="
				+ getGolsSofridos() + ", getSaldoGols()=" + getSaldoGols() + ", getPontos()=" + getPontos()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}

}
