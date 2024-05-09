package com.example.gititfininterview.exceptions;

@SuppressWarnings("serial")
public class SendOTPFailedException extends Exception {

    private final int statusCode;

    public SendOTPFailedException(String message) {
        super(message);
        this.statusCode = 500;
    }

    public SendOTPFailedException(int statusCode, String message) {
        super(message);
        this.statusCode = statusCode;
    }

    public int getStatusCode() {
        return statusCode;
    }

}
