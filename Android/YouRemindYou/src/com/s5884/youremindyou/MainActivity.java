package com.s5884.youremindyou;

import java.util.ArrayList;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.s5884.youremindyou.MainActivity;
//import com.s5884.youremindyou.MainActivity.DataLoadTask;
import com.s5884.youremindyoudb.RecordDaoItem;
import com.s5884.youremindyou.R;
import com.s5884.youremindyoudb.RecordItem;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Color;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

public class MainActivity extends Activity implements OnClickListener {

	// ----------------------------------------------------------
	// ////////////////// In-class Variables ////////////////////
	// ----------------------------------------------------------
	private RecordItem Record = null;
	private ListView listNext = null;
	private ListView listFollowing = null;
	private ArrayAdapter<RecordItem> arrayAdapter = null;
	private ArrayAdapter<RecordItem> arrayAdapter2 = null;
	boolean isWordSearch = false;
	// private ArrayList<String> arrayTitle = null;
	// private ArrayList<Long> arrayAlarmTime = null;

	// ----------------------------------------------------------
	// ///////////////////// List Contents //////////////////////
	// ----------------------------------------------------------
	// Text for ListView1(next voice)
	private final String[] mainText = new String[] { "brainstorming for AOAC" };
	// SubText for ListView1(next voice)
	private final String[] subText = new String[] { "03/10 10:00" };

	// Text for ListView2(following voices)
	private final String[] mainText2 = new String[] {
			"pick one and clarify the concept", "define neccesary functions",
			"make a sitemap", "draw a wireframe", "design a sample of UI",
			"layout it by programming" };
	// SubText for ListView2(following voices)
	private final String[] subText2 = new String[] { "03/10 11:30",
			"03/10 13:00", "03/10 13:30", "03/10 14:00", "03/10 15:30",
			"03/10 20:30" };

	// ----------------------------------------------------------
	// ////////////////////// onCreate() ////////////////////////
	// ----------------------------------------------------------
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// ======================= Image Button =======================
		// get Image Button
		final ImageButton imageBtn = (ImageButton) findViewById(R.id.imageButton1);
		// set where to tell the click event
		imageBtn.setOnClickListener(this);

		// ======================= List View =======================
		// listNext = (ListView) findViewById(R.id.listView1);
		// listFollowing = (ListView) findViewById(R.id.listView2);
		//
		// arrayAdapter = new ArrayAdapter<RecordItem>(this, R.layout.listview);
		// listNext.setAdapter(arrayAdapter);
		// arrayAdapter2 = new ArrayAdapter<RecordItem>(this,
		// R.layout.listview);
		// listFollowing.setAdapter(arrayAdapter2);
		//
		Record = new RecordItem();

		// generate strings for ListView
		final List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for (int i = 0; i < mainText.length; i++) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("main", mainText[i]);
			map.put("sub", subText[i]);
			list.add(map);
		}
		final List<Map<String, String>> list2 = new ArrayList<Map<String, String>>();
		for (int i = 0; i < mainText2.length; i++) {
			Map<String, String> map2 = new HashMap<String, String>();
			map2.put("main2", mainText2[i]);
			map2.put("sub2", subText2[i]);
			list2.add(map2);
		}

		// // generate strings for ListView
		// final List<Map<String, String>> list = new ArrayList<Map<String,
		// String>>();
		// final List<Map<String, String>> list2 = new ArrayList<Map<String,
		// String>>();
		//
		// if (arrayTitle.size() != null) {
		// for (int i = 0; i < arrayTitle.size(); i++) {
		// Map<String, String> map = new HashMap<String, String>();
		// map.put("main", arrayTitle.get(i));
		// map.put("sub", arrayAlarmTime.get(i).toString());
		// list.add(map);
		// }
		// for (int i = 0; i < arrayTitle.size(); i++) {
		// Map<String, String> map2 = new HashMap<String, String>();
		// map2.put("main", arrayTitle.get(i));
		// map2.put("sub", arrayAlarmTime.get(i).toString());
		// list2.add(map2);
		// }
		// }

		// generate an Adapter
		SimpleAdapter adapter = new SimpleAdapter(this, list,
				android.R.layout.simple_list_item_2, new String[] {
						"main", "sub" }, new int[] {
						android.R.id.text1, android.R.id.text2 });
		SimpleAdapter adapter2 = new SimpleAdapter(this, list2,
				android.R.layout.simple_list_item_2, new String[] {
						"main2", "sub2" }, new int[] { android.R.id.text1,
						android.R.id.text2 });

		// add data(stored in Adapter) into ListView
		ListView listView1 = (ListView) findViewById(R.id.listView1);
		listView1.setAdapter(adapter);
		ListView listView2 = (ListView) findViewById(R.id.listView2);
		listView2.setAdapter(adapter2);

		// // set events when each of items is clicked
		// listView1.setOnItemClickListener(new
		// AdapterView.OnItemClickListener() {
		// public void onItemClick(AdapterView<?> parent, View view, int pos,
		// long id) {
		// // 項目選択時の処理を記述
		// // 引数 pos が選択された項目のインデックス (0 始まり)
		// }
		// });

	}

	// ----------------------------------------------------------
	// /////////////////////// onClick() ////////////////////////
	// ----------------------------------------------------------
	@Override
	public void onClick(View view) {
		switch (view.getId()) {
		case R.id.imageButton1:
			// create an instance of Intent
			Intent intent = new Intent(MainActivity.this,
					AddVoiceActivity.class);
			// go to next screen
			startActivity(intent);
			break;
		}
	}

	// // ----------------------------------------------------------
	// // /////////////////////// onResume() ///////////////////////
	// // ----------------------------------------------------------
	// @Override
	// protected void onResume() {
	// super.onResume();
	//
	// /* 一覧取得タスクの実行 */
	// DataLoadTask task = new DataLoadTask();
	// task.execute();
	// }

//	// ----------------------------------------------------------
//	// //////////////////// load & get data /////////////////////
//	// ----------------------------------------------------------
//	public class DataLoadTask extends
//			AsyncTask<Object, Integer, List<RecordItem>> {
//
//		private ProgressDialog progressDialog = null;
//
//		@Override
//		protected void onPreExecute() {
//			/* 処理中ダイアログ表示 */
//			progressDialog = new ProgressDialog(MainActivity.this);
//			progressDialog.setMessage(getResources().getText(R.string.loading));
//			progressDialog.setIndeterminate(true);
//			progressDialog.show();
//		}
//
//		@Override
//		protected List<RecordItem> doInBackground(Object... params) {
//			/* 一覧を呼び出し */
//			RecordDaoItem dao = new RecordDaoItem(MainActivity.this);
//
//			return dao.list_search_item(Record, isWordSearch);
//		}
//
//		protected void onPostExecute(List<RecordItem> result) {
//			/* 処理中ダイアログをクローズ */
//			progressDialog.dismiss();
//
//			/* 現在の一覧表示をクリア */
//			arrayAdapter.clear();
//
//			/* 一覧表示のデータを設定 */
//			for (RecordItem item : result) {
//				// arrayAdapter.add(item);
//				arrayTitle.add(item.getItemTitle());
//				arrayAlarmTime.add(item.getItemAlarmTime());
//
//			}
//
//			isWordSearch = false;
//		}
//	}
}