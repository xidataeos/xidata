package com.fbs.wowo.exception;

import com.fbs.wowo.base.ErrorCode;
import org.apache.shiro.authz.AuthorizationException;

/**
 * 没登录
 */
@SuppressWarnings("serial")
public class UnloginException extends AuthorizationException {

	public UnloginException() {
		super("un login account");
	}

	public UnloginException (ErrorCode error) {
		super(error.getMsg());
		this.error = error;
	}

	private ErrorCode error;

	public ErrorCode getError() {
		return error;
	}

	public void setError(ErrorCode error) {
		this.error = error;
	}
}
