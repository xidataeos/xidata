package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

/**
 */
@SuppressWarnings("serial")
public class CreateEntityFailedException extends BaseException {

	public CreateEntityFailedException() {
		super(ErrorCode.ERR_CREATE_FAILED);
	}

	public CreateEntityFailedException(ErrorCode error) {
		super(error);
	}
	
}
