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

import br.com.SpringPaulistao.model.Times;
import br.com.SpringPaulistao.persistence.SorteioDao;

@Controller
public class IndexController {
	
	@Autowired
	SorteioDao sDao;

	@RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("index");
	}
	
	@RequestMapping(name = "index", value = "/index", method = RequestMethod.POST)
	public ModelAndView sorteio(ModelMap model,  
			@RequestParam Map<String, String> allParam) {
//		String codigoTime = allParam.get("codigoTime");
//		String nomeTime = allParam.get("nomeTime");
//		String cidade = allParam.get("cidade");
//		String estadio = allParam.get("estadio");
		String botao = allParam.get("botao");
		
		List<Times> grupos = new ArrayList<Times>();
		String erro = "";

		try {
			if (botao.equals("Sortear")) {
				grupos = sDao.findTimes();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("grupos", grupos);
//			model.addAttribute("codigoTime", codigoTime);
//			model.addAttribute("nomeTime", nomeTime);
//			model.addAttribute("cidade", cidade);
//			model.addAttribute("estadio", estadio);
			model.addAttribute("erro", erro);
		}
		
		return new ModelAndView("index");
	}

}
