package com.prashant.springappdatum.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.prashant.springappdatum.utils.Services;
import com.prashant.springappdatum.utils.ServicesImplementation;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	//THESE CONSTANTS ARE PASSED AS QUERY PARAM by AJAX REQUEST
	static final String QUERY_ZONE = "{\"keyword\" : [\"zone\"]}";
	static final String QUERY_DISTRICT = "{\"keyword\" : [\"district\"]}";
	static final String QUERY_BOTH = "{\"keyword\" : [\"zone\", \"district\"]}";
	Services service;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/getCategories")
	public void myController(HttpServletRequest request, HttpServletResponse response) throws IOException {
		service = new ServicesImplementation();
		String query = request.getParameter("query");
		//System.out.println(query);
		if(query.equals(QUERY_ZONE)){
			String JSON = service.JSONizeTheList(service.getZones());
			String requiredJSON = "{\"zone\": " + JSON + "}";
			response.getWriter().println(requiredJSON);
			
		}else if(query.equals(QUERY_DISTRICT)){
			String JSON = service.JSONizeTheList(service.getDistricts());
			String requiredJSON = "{\"district\": " + JSON + "}";
			//SEND RESPONSE
			response.getWriter().println(requiredJSON);
			
		}else if(query.equals(QUERY_BOTH)){
			response.getWriter().println(service.getBoth());
		}else{
			System.out.println("ERROR");
		}
	}
	
}
