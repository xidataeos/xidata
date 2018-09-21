package com.wowo.wowo.Message.db;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteStatement;

import de.greenrobot.dao.AbstractDao;
import de.greenrobot.dao.Property;
import de.greenrobot.dao.internal.DaoConfig;


// THIS CODE IS GENERATED BY greenDAO, DO NOT EDIT.

/**
 * DAO for table BLACK_LIST.
*/
public class BlackListDao extends AbstractDao<BlackList, String> {

    public static final String TABLENAME = "BLACK_LIST";

    /**
     * Properties of entity BlackList.<br/>
     * Can be used for QueryBuilder and for referencing column names.
    */
    public static class Properties {
        public final static Property UserId = new Property(0, String.class, "userId", true, "USER_ID");
        public final static Property Status = new Property(1, String.class, "status", false, "STATUS");
        public final static Property Timestamp = new Property(2, Long.class, "timestamp", false, "TIMESTAMP");
    }


    public BlackListDao(DaoConfig config) {
        super(config);
    }

    public BlackListDao(DaoConfig config, DaoSession daoSession) {
        super(config, daoSession);
    }

    /** Creates the underlying database table. */
    public static void createTable(SQLiteDatabase db, boolean ifNotExists) {
        String constraint = ifNotExists ? "IF NOT EXISTS " : "";
        db.execSQL("CREATE TABLE " + constraint + "'BLACK_LIST' (" + //
                   "'USER_ID' TEXT PRIMARY KEY NOT NULL ," + // 0: userId
                   "'STATUS' TEXT," + // 1: status
                   "'TIMESTAMP' INTEGER);"); // 2: timestamp
    }

    /** Drops the underlying database table. */
    public static void dropTable(SQLiteDatabase db, boolean ifExists) {
        String sql = "DROP TABLE " + (ifExists ? "IF EXISTS " : "") + "'BLACK_LIST'";
        db.execSQL(sql);
    }

    /** @inheritdoc */
    @Override
    protected void bindValues(SQLiteStatement stmt, BlackList entity) {
        stmt.clearBindings();
        stmt.bindString(1, entity.getUserId());

        String status = entity.getStatus();
        if (status != null) {
            stmt.bindString(2, status);
        }

        Long timestamp = entity.getTimestamp();
        if (timestamp != null) {
            stmt.bindLong(3, timestamp);
        }
    }

    /** @inheritdoc */
    @Override
    public String readKey(Cursor cursor, int offset) {
        return cursor.getString(offset + 0);
    }

    /** @inheritdoc */
    @Override
    public BlackList readEntity(Cursor cursor, int offset) {
        BlackList entity = new BlackList( //
            cursor.getString(offset + 0), // userId
            cursor.isNull(offset + 1) ? null : cursor.getString(offset + 1), // status
            cursor.isNull(offset + 2) ? null : cursor.getLong(offset + 2) // timestamp
        );
        return entity;
    }

    /** @inheritdoc */
    @Override
    public void readEntity(Cursor cursor, BlackList entity, int offset) {
        entity.setUserId(cursor.getString(offset + 0));
        entity.setStatus(cursor.isNull(offset + 1) ? null : cursor.getString(offset + 1));
        entity.setTimestamp(cursor.isNull(offset + 2) ? null : cursor.getLong(offset + 2));
    }

    /** @inheritdoc */
    @Override
    protected String updateKeyAfterInsert(BlackList entity, long rowId) {
        return entity.getUserId();
    }

    /** @inheritdoc */
    @Override
    public String getKey(BlackList entity) {
        if (entity != null) {
            return entity.getUserId();
        } else {
            return null;
        }
    }

    /** @inheritdoc */
    @Override
    protected boolean isEntityUpdateable() {
        return true;
    }

}
