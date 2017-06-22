package com.itc.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

	public static boolean sendActivationKeyEmail(String activationKey) {

		String from = "smgenie.servicedesk@itcinfotech.com";
		String to = "haiksk@gmail.com";
		// String cc = "ricks21@gmail.com";

		// Assuming you are sending email from localhost
		String host = "10.6.12.229";

		// Get system properties
		Properties properties = System.getProperties();

		// Setup mail server
		properties.setProperty("mail.smtp.host", host);
		properties.setProperty("mail.smtp.port", "25");

		// Get the default Session object.
		Session session = Session.getDefaultInstance(properties);

		try {
			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);

			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));

			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			// message.addRecipient(Message.RecipientType.CC, new
			// InternetAddress(cc));

			// Set Subject: header field
			message.setSubject("Activation Key - Test");

			// Now set the actual message
			StringBuilder sb = new StringBuilder();
			sb.append("Dear User,<br/><br/>").append("Please use the following key to verify your account.<br/>")
					.append("<b>" + activationKey + "</b><br/><br/>").append("Regards,<br/>").append("ITC Infotech");
			message.setContent(sb.toString(), "text/html; charset=utf-8");

			// Send message
			Transport.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void main(String[] args) {
	}
}
