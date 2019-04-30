package cn.qdas.core.bean;

import java.util.HashMap;
import java.util.Map;

public class Filter extends Page{
	private Map<String,String> filter=new HashMap<String, String>();
	public Map<String,String> getFilter() {
		return filter;
	}
	public void setFilter(Map<String, String> filter) {
		this.filter = filter;
	}
	 
	public String get(String key){
		if(filter ==null){
			return null;
		}else{
			return filter.get(key);
		}
	} 
	
	public void set(String key,String value){
		filter.put(key,value);
	}
}
