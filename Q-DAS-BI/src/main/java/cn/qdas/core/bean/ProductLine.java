package cn.qdas.core.bean;

public class ProductLine {
	private String id;
	private String productLineName;
	private String available;
	private String availableStr;
	public String getProductLineName() {
		return productLineName;
	}
	public void setProductLineName(String productLineName) {
		this.productLineName = productLineName;
	}
	public String getAvailable() {
		return available;
	}
	public void setAvailable(String available) {
		this.available = available;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAvailableStr() {
		return availableStr;
	}
	public void setAvailableStr(String availableStr) {
		this.availableStr = availableStr;
	}
	
}
