package cn.qdas;

import java.io.File;
import java.io.IOException;

import javax.jms.JMSException;
import javax.swing.JFileChooser;

public class ProducterMain {

	public static void main(String[] args) throws JMSException, IOException {
		//Producter p=new Producter();
		//p.sendMessage("text_str", "发送的第1212条 信息");
		JFileChooser fileChooser = new JFileChooser();  
        fileChooser.setDialogTitle("请选择要传送的文件");  
        if (fileChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {  
            return;  
        }  
        File file = fileChooser.getSelectedFile();  
		//p.sendFile("file",file);
        Producer p=new Producer();
        p.init();
        p.sendMessage("file", file);
	}

}
