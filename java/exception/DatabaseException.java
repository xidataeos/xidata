package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

import static com.fbs.wowo.base.ErrorCode.ERR_DB;
import static com.fbs.wowo.base.ErrorCode.ERR_NULL_DATA;

public class DatabaseException extends BaseException {

    public DatabaseException() {
        super(ERR_NULL_DATA);
    }

    public DatabaseException(ErrorCode error) {
        super(error);
    }

    public DatabaseException(Exception e) {
        super(e.getMessage(), ERR_DB);
    }
}
