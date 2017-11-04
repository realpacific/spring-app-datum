package com.prashant.springappdatum.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SQLConnection {

	public static Connection dbConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/springdatum", "root", "");
			return connection;
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			return null;
		}

	}
}
