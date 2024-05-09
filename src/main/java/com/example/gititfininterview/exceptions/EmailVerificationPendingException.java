package com.example.gititfininterview.exceptions;

public class EmailVerificationPendingException extends Exception {
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public EmailVerificationPendingException(String message) {
        super(message);
    }
}
