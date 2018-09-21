package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

/**
 */
@SuppressWarnings("serial")
public class GivenNullParamException extends BaseException {

	public GivenNullParamException() {
		super(ErrorCode.ERR_NULL_PARAM);
	}

	public GivenNullParamException(ErrorCode error) {
		super(error);
	}
	
}
