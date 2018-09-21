package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

import static com.fbs.wowo.base.ErrorCode.ERR_NULL_DATA;

/**
 * 数据库查不到本因有的数据
 */
@SuppressWarnings("serial")
public class NoSuchDataException extends BaseException {

	public NoSuchDataException() {
		super(ERR_NULL_DATA);
	}

	public NoSuchDataException(ErrorCode error) {
		super(error);
	}
}
