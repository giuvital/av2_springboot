package br.com.SpringPaulistao.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.SpringPaulistao.model.AttResultado;
import br.com.SpringPaulistao.model.Jogos;
import br.com.SpringPaulistao.model.Quartas;
import br.com.SpringPaulistao.model.Resultado;
import br.com.SpringPaulistao.persistence.IJogosDao;

@Controller
public class JogosController {

	@Autowired
	IJogosDao jDao;

	@RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("jogos");
	}

	@RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.POST)
	public ModelAndView rodadas(ModelMap model, @RequestParam Map<String, String> allParam) {
		String data = allParam.get("data");
		String botao = allParam.get("botao");

		Jogos jogos = new Jogos();

		List<Jogos> lista = new ArrayList<Jogos>();
		List<Resultado> classif = new ArrayList<Resultado>();
		List<Quartas> jogosQuartas = new ArrayList<Quartas>();
		String erro = "";

		try {
			if (botao.equals("Resultados")) {
				lista = jDao.pesquisarPorData(data);
			}
			if (botao.equals("Classificacao")) {
				classif = jDao.classificacao();
			}
			if (botao.equals("Quartas")) {
				jogosQuartas = jDao.getQuartas();
			}
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("listaJogos", lista);
			model.addAttribute("classif", classif);
			model.addAttribute("jogosQuartas", jogosQuartas);
			model.addAttribute("data", data);
			model.addAttribute("erro", erro);
		}

		return new ModelAndView("jogos");
	}

	@RequestMapping(name = "update", value = "/update", method = RequestMethod.POST)
	public ModelAndView atualizar(ModelMap model, @RequestParam Map<String, String> allParam) {
		AttResultado att = new AttResultado();
		List<AttResultado> listaUpdate = new ArrayList<AttResultado>();
		for (String key : allParam.keySet()) {

			if (key.contains("codigoJogo")) {
				att.setCodigoJogo(Integer.parseInt(allParam.get(key)));

			}

			if (key.contains("golsTimeA")) {
				att.setGolsTimeA(Integer.parseInt(allParam.get(key)));

			}

			if (key.contains("golsTimeB")) {
				att.setGolsTimeB(Integer.parseInt(allParam.get(key)));

				listaUpdate.add(AttResultado.deepCopy(att));
			}

		}

		for (AttResultado res : listaUpdate) {
			try {
				jDao.update(res);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return new ModelAndView("jogos");
	}
}
