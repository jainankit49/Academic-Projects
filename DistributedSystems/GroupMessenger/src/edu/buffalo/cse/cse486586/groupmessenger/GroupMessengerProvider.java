package edu.buffalo.cse.cse486586.groupmessenger;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.net.Uri;

public class GroupMessengerProvider extends ContentProvider {

	private static final Uri providerURI = Uri
			.parse("content://edu.buffalo.cse.cse486586.groupmessenger.provider");
	private static final String key = "key";
	private static final String value = "value";
	Context cntx;

	@Override
	public int delete(Uri uri, String selection, String[] selectionArgs) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getType(Uri uri) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see android.content.ContentProvider#insert(android.net.Uri,
	 * android.content.ContentValues)
	 * 
	 * values provided
	 * Key act as filename and value should be stored in that file
	 */
	@Override
	public Uri insert(Uri uri, ContentValues values) {
		// TODO Auto-generated method stub
		String key_ = (String) values.get(key);
		String val_ = (String) values.get(value);

		FileOutputStream fileOS;
		try {
			fileOS = cntx.openFileOutput(key_, Context.MODE_PRIVATE);
			OutputStreamWriter oWrtr = new OutputStreamWriter(fileOS);
			oWrtr.write(val_);
			oWrtr.close();
			fileOS.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return uri;
	}

	@Override
	public boolean onCreate() {
		// TODO Auto-generated method stub
		cntx = getContext();
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see android.content.ContentProvider#query(android.net.Uri,
	 * java.lang.String[], java.lang.String, java.lang.String[],
	 * java.lang.String)
	 * 
	 * Key is provided, keys acts as file name and value is stored in that file
	 */
	@Override
	public Cursor query(Uri uri, String[] projection, String selection,
			String[] selectionArgs, String sortOrder) {
		// TODO Auto-generated method stub

		String key_ = selection;
		String val_ = null;
		String cols[] = { key, value };
		FileInputStream fileIS;
		try {

			fileIS = cntx.openFileInput(key_);
			InputStreamReader iRdr = new InputStreamReader(fileIS);
			BufferedReader bRdr = new BufferedReader(iRdr);
			val_ = bRdr.readLine();

			bRdr.close();
			iRdr.close();
			fileIS.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//provide cursor as return type
		MatrixCursor mtrCrsr = new MatrixCursor(cols);
		String values[] = { key_, val_ };
		mtrCrsr.addRow(values);
		return mtrCrsr;
	}

	@Override
	public int update(Uri uri, ContentValues values, String selection,
			String[] selectionArgs) {
		// TODO Auto-generated method stub
		return 0;
	}

}
