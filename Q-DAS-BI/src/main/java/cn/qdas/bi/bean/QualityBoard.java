package cn.qdas.bi.bean;

public class QualityBoard {
	private String productLineName;
	private String teilNum;
	private String teilId;
	private String teilName;
	private String merkmalName;
	private String merkmalId;
	private String startTime;
	private String endTime;
	public String getProductLineName() {
		return productLineName;
	}

	public void setProductLineName(String productLineName) {
		this.productLineName = productLineName;
	}

	public String getTeilNum() {
		return teilNum;
	}

	public void setTeilNum(String teilNum) {
		this.teilNum = teilNum;
	}

	public String getTeilId() {
		return teilId;
	}

	public void setTeilId(String teilId) {
		this.teilId = teilId;
	}

	public String getMerkmalName() {
		return merkmalName;
	}

	public void setMerkmalName(String merkmalName) {
		this.merkmalName = merkmalName;
	}

	public String getMerkmalId() {
		return merkmalId;
	}

	public void setMerkmalId(String merkmalId) {
		this.merkmalId = merkmalId;
	}

	public String getTeilName() {
		return teilName;
	}

	public void setTeilName(String teilName) {
		this.teilName = teilName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
}
