package com.s5884.youremindyoudb;

import java.util.ArrayList;
import java.util.List;

import com.s5884.youremindyoudb.RecordItem;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

/**
 * データアクセスクラス
 */
public class RecordDaoItem {

	private DatabaseOpenHelperItem helper = null;

	public RecordDaoItem(Context context) {
		helper = new DatabaseOpenHelperItem(context);
	}

	/**
	 * レコードの保存
	 */
	public RecordItem save_item(RecordItem item) {
		SQLiteDatabase db = helper.getWritableDatabase();
		RecordItem result = null;

		try {
			ContentValues values = new ContentValues();
			values.put(RecordItem.COLUMN_ITEMTITLE, item.getItemTitle());
			values.put(RecordItem.COLUMN_ITEMALARMTIME, item.getItemAlarmTime());

			int rowId = item.getRowid();

			if (rowId == 0) {
				rowId = (int) db.insert(RecordItem.TABLE_NAME_ITEM, null,
						values);
			} else {
				db.update(RecordItem.TABLE_NAME_ITEM, values,
						RecordItem.COLUMN_ID + "=?",
						new String[] { String.valueOf(rowId) });
			}
			result = load_item(rowId);

		} finally {
			db.close();
		}
		return result;
	}

	/**
	 * レコードの削除
	 */
	public void delete_item(RecordItem item) {
		SQLiteDatabase db = helper.getWritableDatabase();
		try {
			db.delete(RecordItem.TABLE_NAME_ITEM, RecordItem.COLUMN_ID + "=?",
					new String[] { String.valueOf(item.getRowid()) });
		} finally {
			db.close();
		}
	}

	/**
	 * レコードの全件削除
	 */
	public void deleteall_item() {
		SQLiteDatabase db = helper.getWritableDatabase();
		try {
			String query = "delete from " + RecordItem.TABLE_NAME_ITEM
					+ " where " + RecordItem.COLUMN_ID + ">-1;";
			db.execSQL(query);
		} finally {
			db.close();
		}
	}

	/**
	 * idでRecordをロードする
	 */
	public RecordItem load_item(int itemId) {
		SQLiteDatabase db = helper.getReadableDatabase();

		RecordItem number = null;
		try {
			String query = "select * " + " from " + RecordItem.TABLE_NAME_ITEM
					+ " where " + RecordItem.COLUMN_ID + " = '" + itemId + "';";
			Cursor cursor = db.rawQuery(query, null);
			cursor.moveToFirst();
			number = getItem(cursor);
		} finally {
			db.close();
		}
		return number;
	}

	/**
	 * 検索
	 */
	public List<RecordItem> list_search_item(RecordItem record,
			boolean searchWord) {
		SQLiteDatabase db = helper.getReadableDatabase();

		List<RecordItem> itemList;

		try {
			String query = null;

			query = "select * " + " from " + RecordItem.TABLE_NAME_ITEM + ";";

			Cursor cursor = db.rawQuery(query, null);

			itemList = new ArrayList<RecordItem>();
			cursor.moveToFirst();
			while (!cursor.isAfterLast()) {
				itemList.add(getItem(cursor));
				cursor.moveToNext();
			}
		} finally {
			db.close();
		}
		return itemList;
	}

	/**
	 * カーソルからオブジェクトへの変換
	 */
	private RecordItem getItem(Cursor cursor) {
		RecordItem item = new RecordItem();

		item.setRowid((int) cursor.getLong(0));
		item.setItemTitle(cursor.getString(1));
		item.setItemAlarmTime((int) cursor.getLong(2));
		return item;
	}
}
