package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseController;
import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

import static com.fbs.wowo.base.ErrorCode.ERR_INPUT_INCORRECT;

/**
 */
@SuppressWarnings("serial")
public class InputVerifyFailedException extends BaseException {

	public InputVerifyFailedException() {
		super(ERR_INPUT_INCORRECT);
	}

	public InputVerifyFailedException(ErrorCode error) {
		super(error);
	}
}
