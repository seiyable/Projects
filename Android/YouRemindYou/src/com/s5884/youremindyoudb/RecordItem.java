package com.s5884.youremindyoudb;

import java.io.Serializable;

@SuppressWarnings("serial")
public class RecordItem implements Serializable{

	/* テーブル名 */
	public static final String TABLE_NAME_ITEM = "tbl_voice_alarms";

	/* カラム名 */
    /* 実際のDataBaseに記録されるカラム名 */
	public static final String COLUMN_ID = "_id";
	public static final String COLUMN_ITEMTITLE = "title";
	public static final String COLUMN_ITEMALARMTIME = "alarmtime";

	/* プロパティ */
    /* 保存の情報や検索情報などを保持するものになります */
	private int rowid = 0;
	private String itemtitle = null;
	private long itemalarmtime = 0;

    /* プロパティを操作するメソッド達です */
	public int getRowid() { return rowid; }
	public void setRowid(int rowid) { this.rowid = rowid; }

	public String getItemTitle() { return itemtitle; }
	public void setItemTitle(String paramTitle) { this.itemtitle = paramTitle; }
	
	public long getItemAlarmTime() { return itemalarmtime; }
	public void setItemAlarmTime(long paramAlarmTime) { this.itemalarmtime = paramAlarmTime; }
	

    /**
     * ListViewで表示します
     */
	@Override
	public String toString() {

		/* 日記の本文を取得 */
		String title = getItemTitle();
		/* 改行を削除 */
		title = title.replaceAll( "\n", "" );

		StringBuilder builder = new StringBuilder();
		builder.append(getItemAlarmTime());

		return builder.toString();
	}
}
