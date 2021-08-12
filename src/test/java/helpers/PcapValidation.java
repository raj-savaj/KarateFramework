package helpers;

import java.io.IOException;
import java.io.OutputStream;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class PcapValidation {

    private JSch jsch;
    private Session session;
    private Channel channel;
    private Thread thread = null;

    public PcapValidation(){
        jsch = new JSch();
        try {
            System.out.println("PcapValidation class executed");
            session = jsch.getSession("haudsysops", "192.168.20.22",22);
            session.setPassword("haudsysops");
            session.setConfig("StrictHostKeyChecking", "no");
        } catch (JSchException e) {
            e.printStackTrace();
        }
       
    }
    
    public void startPcapReading() {
        System.out.println("startPcapReading method running.");
    	thread = new Thread(new Runnable() {
			public void run() {
				connectChanel();
			}
		});
		thread.start();
    }
    
    public void stopPcapReading() {
        System.out.println("stopPcapReading method running.");
    	if (thread != null) {
    		closeChannel();
			thread.interrupt();
			System.out.println("Thread successfully stopped.");
		}
    }
    
    public void connectChanel(){
        try {
            session.connect();
            channel=session.openChannel("exec");
            ((ChannelExec) channel).setPty(true);
            ((ChannelExec)channel).setCommand("sudo -S -p '' tcpdump -i any -w test121.pcap");
            ((ChannelExec)channel).setErrStream(System.err);
            OutputStream out=channel.getOutputStream();
            channel.connect();
            out.write("haudsysops\n".getBytes());
            out.flush();
            System.out.println("Thread successfully started.");
        } catch (JSchException  | IOException e) {
            e.printStackTrace();
        }
    }

    public void closeChannel(){
        if(channel!=null && session!=null){
            try {
                channel.sendSignal("2");
                System.out.println("redis_stop_log");
                channel.disconnect();
                session.disconnect();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
