package edu.buffalo.cse.cse486586.groupmessenger;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;

import android.content.ContentResolver;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.os.AsyncTask;
import android.util.Log;

public class OnClickingSend implements OnClickListener {
	private static final String remotePorts []= {"11108","11112","11116","11120","11124"};
	static int arVecClock [] = {0,0,0,0,0};
	final String TAG = ("Ankit Log");	
	private final TextView tv;
	private final ContentResolver cr;
	String myPort;
	
	public OnClickingSend(TextView tv, ContentResolver cr, String myPort) {
		this.tv = tv;
		this.cr = cr;
		this.myPort=myPort;
	}
	/*
	 * TODO: You need to register and implement an OnClickListener for the "Send" button.
	 * In your implementation you need to get the message from the input box (EditText)
	 * and send it to other AVDs in a total-causal order.
	 */
	@Override
	public void onClick(View arg0) {
		Log.e(TAG,"Hi I am inside onClick");
		String msg = tv.getText().toString();
		tv.setText(""); 
		new ClientTask().executeOnExecutor(AsyncTask.SERIAL_EXECUTOR, msg, myPort);
		Log.e(TAG,"Exiting onClick");
	}

	private class ClientTask extends AsyncTask<String, Void, Void>  {
		ObjectOutputStream outStrm;
		Message message;
		Socket socket;
		@Override
		protected Void doInBackground(String... msgs) {

			Log.e(TAG, "Hi I am inside ClientTask");
			int counter=0;

			for (int i=0;i<5;i++){
				while(counter<6){
					Log.e(TAG,"counter"+counter);
					try {
						socket = new Socket(InetAddress.getByAddress(new byte[]{10, 0, 2, 2}),Integer.parseInt(remotePorts[i]));
						String msgToSend = msgs[0];
						Log.e(TAG, "msgTosend: "+msgToSend);
						message=new Message(msgToSend,"",false,OnClickingSend.arVecClock,myPort);
						outStrm= new ObjectOutputStream(socket.getOutputStream()); 
						outStrm.writeObject(message);
						Log.e(TAG, "Receiver port is: "+remotePorts[i]);
						counter=0;
						outStrm.close();    
						socket.close();
						break;
					} 
					catch (UnknownHostException e) {
						Log.e(TAG, "ClientTask UnknownHostException");
					} catch (IOException e) {
						counter++;
						Log.e("ClientTask Socket IOException",remotePorts[i]);
					}
				}
				counter=0;
			}
			return null;
		}			
	}
}

