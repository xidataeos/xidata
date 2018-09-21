package com.fbs.wowo.exception;

import com.fbs.wowo.base.BaseException;
import com.fbs.wowo.base.ErrorCode;

/**
 */
@SuppressWarnings("serial")
public class UploadException extends BaseException {

	public UploadException() {
		super();
	}

	public UploadException(ErrorCode error) {
		super(error);
	}

}
