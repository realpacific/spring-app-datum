package com.prashant.springappdatum.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.prashant.springappdatum.connection.SQLConnection;

public class ServicesImplementation implements Services {

	@Override
	public List<String> getDistricts() {
		List<String> list = new ArrayList<String>();
		try {
			Connection connection = SQLConnection.dbConnection();
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM enum_district;");
			while (rs.next()) {
				String name = rs.getString("district");
				list.add(name);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<String> getZones() {
		List<String> list = new ArrayList<String>();
		try {
			Connection connection = SQLConnection.dbConnection();
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM enum_zone;");
			while (rs.next()) {
				String name = rs.getString("zone");
				//System.out.println(name);
				list.add(name);
			}
			//System.out.println(list);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public String getBoth() {	
		String districts = "{\"district\": " + JSONizeTheList(getDistricts()) + "}";
		String zones = "{\"zone\": " + JSONizeTheList(getZones()) + "}";
		String both = " {\"result\" :[  " + districts +","+ zones + "]}";
		return both;
	}
	
	/*
	 * LIST -> JSON
	*/
	@Override
	public String JSONizeTheList(List<String> list) {
		String json = new Gson().toJson(list);
		return json;
	}

}
