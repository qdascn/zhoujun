package cn.qdas;

import javax.jms.JMSException;

public class ComsumerMain {

	public static void main(String[] args) throws JMSException {
		Comsumer comsumer=new Comsumer();
		//String msg=comsumer.getMessage("text_str");
		comsumer.init();
		comsumer.getFile("file");
	}

}
