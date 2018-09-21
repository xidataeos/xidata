package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

/**
 */
@SuppressWarnings("serial")
public class DataOverflowException extends BaseException {

	public DataOverflowException() {
		super(ErrorCode.ERR_DATA_OVERFLOW);
	}

	public DataOverflowException(ErrorCode error) {
		super(error);
	}

}
