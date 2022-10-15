package com.company.project.controllers;

import com.company.project.entity.Greeting;
import com.company.project.repository.GreetingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class HomeController {

	@Autowired
	private GreetingRepository repository;

	@GetMapping("/{id}")
	@ResponseBody

	public Greeting showHome(@PathVariable(required = false) int id, String name, Model model) {
		return repository.findById(id).orElse(new Greeting("Not Found try again and again! v0.0.1😕"));
		// model = model.addAttribute("name", dockerGreeting.getName());
		// return "home";
	}

}
