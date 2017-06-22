package com.itc.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itc.model.Customer;
import com.itc.util.EmailUtil;

@Controller
public class CustomerController {

	@RequestMapping("/test")
	public ModelAndView testMessage() {
		return new ModelAndView("registration_response", "errorMessage", "Registration Success");
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView registerForm() {
		return new ModelAndView("register", "command", new Customer());
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView registerSave(@ModelAttribute Customer customer) {
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr;
		try {
			jsonStr = mapper.writeValueAsString(customer);
			HttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost request = new HttpPost("http://localhost:8080/RiskValuationService/customer/register");
			StringEntity params = new StringEntity(jsonStr);
			request.addHeader("content-type", "application/json");
			request.setEntity(params);
			HttpResponse response = httpClient.execute(request);

			String line = "";
			BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			line = rd.readLine();
			if (line != null && !line.isEmpty()) {
				JsonParser parser = new JsonParser();
				JsonObject responseJsonObject = parser.parse(line).getAsJsonObject();
				if (responseJsonObject.has("activation_key")) {
					String activationKey = responseJsonObject.get("activation_key").getAsString();

					String message = "";
					if (EmailUtil.sendActivationKeyEmail(activationKey)) {
						// message = "You have registered successfully, please
						// use <b>" + activationKey.trim()
						// + "</b> key to verify your account.";
						message = "You have registered successfully, we have to sent the Activation Key to your registered email id."
								+ "<br/> Please use the same to activate your account";
					} else {
						return new ModelAndView("registration_response", "errorMessage",
								"Some Error Occurred, Please try again.");
					}
					return new ModelAndView("registration_response", "successMessage", message);

				} else if (responseJsonObject.has("error")) {
					String errorMessage = responseJsonObject.get("error").getAsString();
					return new ModelAndView("registration_response", "errorMessage", errorMessage);
				}
			}
		} catch (JsonProcessingException e) {
			return new ModelAndView("registration_response", "errorMessage", "Some Error Occurred, Please try again.");
		} catch (UnsupportedEncodingException e) {
			return new ModelAndView("registration_response", "errorMessage", "Some Error Occurred, Please try again.");
		} catch (ClientProtocolException e) {
			return new ModelAndView("registration_response", "errorMessage", "Some Error Occurred, Please try again.");
		} catch (IOException e) {
			return new ModelAndView("registration_response", "errorMessage", "Some Error Occurred, Please try again.");
		}
		return new ModelAndView("register", "command", new Customer());
	}

	@RequestMapping(value = "/verify", method = RequestMethod.GET)
	public String verifyPage() {
		return "verify_account";
	}

	@RequestMapping(value = "/verify", method = RequestMethod.POST, params = { "email_id", "act_key" })
	public ModelAndView verifyAccount(@RequestParam(value = "email_id") String emailId,
			@RequestParam(value = "act_key") String activationKey) {

		String jsonString = "{\"emailId\":\"" + emailId + "\",\"activationKey\":\"" + activationKey + "\"}";
		try {
			HttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost request = new HttpPost("http://localhost:8080/RiskValuationService/customer/verify");
			StringEntity params = new StringEntity(jsonString);
			request.addHeader("content-type", "application/json");
			request.setEntity(params);
			HttpResponse response = httpClient.execute(request);

			String line = "";
			BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			line = rd.readLine();
			if (line != null && !line.isEmpty()) {
				JsonParser parser = new JsonParser();
				JsonObject responseJsonObject = parser.parse(line).getAsJsonObject();
				if (responseJsonObject.has("success")) {
					String successMsg = responseJsonObject.get("success").getAsString();
					return new ModelAndView("registration_response", "successMessage", successMsg);
				} else if (responseJsonObject.has("error")) {
					String errorMessage = responseJsonObject.get("error").getAsString();
					return new ModelAndView("registration_response", "errorMessage", errorMessage);
				}
			}
		} catch (Exception e) {
			return new ModelAndView("registration_response", "errorMessage", "Some Error Occurred, Please try again.");
		}
		return new ModelAndView("verify_account");
	}
}