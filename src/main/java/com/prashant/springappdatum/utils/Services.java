package com.prashant.springappdatum.utils;

import java.util.List;

public interface Services {
	public List<String> getDistricts();
	public List<String> getZones();
	public String getBoth();
	
	public String JSONizeTheList(List<String> list);

}
