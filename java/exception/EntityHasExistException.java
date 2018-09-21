package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

/**
 */
@SuppressWarnings("serial")
public class EntityHasExistException extends BaseException {

	public EntityHasExistException() {
		super(ErrorCode.ERR_DATA_HAS_EXIST);
	}

	public EntityHasExistException(ErrorCode error) {
		super(error);
	}
	
}
