package edu.buffalo.cse.cse486586.groupmessenger;



import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.Serializable;

import java.io.ObjectInputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.telephony.TelephonyManager;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.Menu;
import android.widget.TextView;

/**
 * GroupMessengerActivity is the main Activity for the assignment.
 * 
 * @author stevko
 *
 */
public class GroupMessengerActivity extends Activity {

	String remotePort []= {"11108","11112","11116","11120","11124"};
	static final String TAG = ("Ankit Log");
	static final int serverPort = 10000;
	public static int sequenceCounter=0;
	Ports ports=new Ports();
	ServerSocket serverSocket;

	private Uri myUri(String scheme, String authority) {
		Uri.Builder uriBuilder = new Uri.Builder();
		uriBuilder.authority(authority);
		uriBuilder.scheme(scheme);
		return uriBuilder.build();
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		Log.e(TAG,"Hi I am inside onCreate");
		setContentView(R.layout.activity_group_messenger);

		TelephonyManager tel = (TelephonyManager) this.getSystemService(Context.TELEPHONY_SERVICE);
		String portStr = tel.getLine1Number().substring(tel.getLine1Number().length() - 4);
		final String myPort = String.valueOf((Integer.parseInt(portStr) * 2));

		Log.e(TAG,"My Avd no. is: " +myPort);

		/*
		 * TODO: Use the TextView to display your messages. Though there is no grading component
		 * on how you display the messages, if you implement it, it'll make your debugging easier.
		 */
		TextView tv = (TextView) findViewById(R.id.textView1);
		tv.setMovementMethod(new ScrollingMovementMethod());
		TextView tv1 = (TextView) findViewById(R.id.editText1);

		/*
		 * Registers OnPTestClickListener for "button1" in the layout, which is the "PTest" button.
		 * OnPTestClickListener demonstrates how to access a ContentProvider.
		 */
		findViewById(R.id.button1).setOnClickListener(new OnPTestClickListener(tv, getContentResolver()));
		findViewById(R.id.button4).setOnClickListener(new OnClickingSend(tv1, getContentResolver(),myPort));
		try {
			serverSocket = new ServerSocket(serverPort);
			ports.myPort=myPort;
			ports.sSocket=serverSocket;
			new ServerTask().executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, ports);
		}
		catch (IOException e) {
			Log.e(TAG, "Can't create a ServerSocket");
			return;
		}
	}
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_group_messenger, menu);
		return true;
	}

	public void addToArray(List<Message> arr, int idx){
		int i=idx;
		while(i<GroupMessengerActivity.sequenceCounter){
			arr.set(i+1, arr.get(i));
		}		
		GroupMessengerActivity.sequenceCounter++;
	}	

	public int portNumber(String myPort){
		for (int i=0;i<5;i++){
			if(String.valueOf(remotePort[i]).equals(myPort)){
				return i;
			}
		}
		return -1;
	}	


	private class ServerTask extends AsyncTask<Ports, Message, Void> {
		ContentValues values= new ContentValues();
		ObjectInputStream instream; 
		Message message; 
		List <Message> sequenceBuf = new LinkedList<Message>();
		Socket client;
		int sequencer = -1;
		@Override
		protected Void doInBackground(Ports... ports) {
			Log.e(TAG,"Hi I am inside doInBackground");
			serverSocket = ports[0].sSocket;
			boolean gate=true;
			while(true){
				try {	
					Log.e(TAG,"server port: "+ports[0].myPort);
					client=serverSocket.accept();
					instream = new ObjectInputStream(client.getInputStream());
					message = (Message)instream.readObject();
					instream.close();	

					if(message.isInOrder){
						Log.e(TAG, "ordered message: " +message.message);
						int messageOrder = Integer.parseInt(message.order);
						if(Math.abs(messageOrder-sequencer) == 1){
							sequencer = messageOrder;
							publishProgress(message);
						}
						else{
							int index=0;
							while(!(index>sequenceCounter)){
								int sequenceOrder = Integer.parseInt(sequenceBuf.get(index).order);

								if(messageOrder - sequenceOrder ==-1){
									if(gate){
										sequencer = messageOrder;
										gate = false;
										publishProgress(message);
									}
									sequencer = sequenceOrder;
									publishProgress(sequenceBuf.get(index));		
									while(index<GroupMessengerActivity.sequenceCounter){
										sequenceBuf.set(index, sequenceBuf.get(++index));
									}		
									GroupMessengerActivity.sequenceCounter--;
								}
								else if (messageOrder < sequenceOrder){
									while(index<GroupMessengerActivity.sequenceCounter){
										sequenceBuf.set(index+1, sequenceBuf.get(index));
									}		
									GroupMessengerActivity.sequenceCounter++;	
								}	
								else if(messageOrder > sequenceOrder){
									index++;
								}
							}
						}	
					}
					else{
						Log.e(TAG, "unordered message: " +message.message);
						int num=portNumber(ports[0].myPort);
						OnClickingSend.arVecClock[num]++;		
						if(ports[0].myPort.equals("11112".toString())){
							if(message.isInOrder =false){
								sequencer++;
								message.order=String.valueOf(sequencer);
								message.isInOrder=true;
								Log.e(TAG,"sending out sequenced message");

								for (int i=0; i< remotePort.length; i++){
									if(i==num)
										continue;
									else
										try {
											Socket socket = new Socket(InetAddress.getByAddress(new byte[]{10, 0, 2, 2}),Integer.parseInt(remotePort[i]));
											ObjectOutputStream out= new ObjectOutputStream(socket.getOutputStream()); 
											out.writeObject(message);
											out.close();    
											socket.close();
										} 
									catch (UnknownHostException e) {
										Log.e("Send to socket from server", "ClientTask UnknownHostException");
									} catch (IOException e) {
										Log.e("Send to socket from server", "ClientTask Socket IOException");
									}
								}
								publishProgress(message);
							}
						}
					}
				}
				catch (IOException e) {
					Log.e(TAG,"Client not accepted");
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				catch (Exception e){
					e.printStackTrace();
				}
			}
		}

		protected void onProgressUpdate(Message...messages) {
			Log.e(TAG, "Hi I am inside onProgressUpdate");
			Uri mURI = myUri("content", "edu.buffalo.cse.cse486586.groupmessenger.provider");	
			values.put("key", messages[0].order);
			values.put("value", messages[0].message);
			ContentResolver mContentResolver=getContentResolver();
			mContentResolver.insert(mURI, values);
			TextView tv = (TextView) findViewById(R.id.textView1);
			tv.append(messages[0].message + "\t\n");
			Log.e(TAG, "exiting onProgressUpdate");
			return;
		}
	}	
}

class Message implements Serializable{
	private static final long serialVersionUID = 0L;
	String message;
	String myPort;
	String order;
	boolean isInOrder;
	int arVecClock[] = new int[5];

	public Message(String message, String order, boolean isInOrder, int arVecClock[], String myPort){
		this.message=message;
		this.myPort=myPort;
		this.order=order;
		this.isInOrder=isInOrder;
		this.arVecClock=arVecClock;		
	}
}

class Ports{
	ServerSocket sSocket;
	String myPort;
}
