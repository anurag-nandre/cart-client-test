package com.twilio.anurag_test;

import com.twilio.cartographer.client.http.CartographerLoadBalancerListener;

import java.util.logging.Logger;

public class TestMonitor implements CartographerLoadBalancerListener {
    private static final Logger log = Logger.getLogger(TestMonitor.class.getName());


    @Override
    public void onStatusChange(boolean inLB) {
        log.info("Change, inLB is nowm " + inLB);
    }

    @Override
    public void onErrorStatus(String message, Throwable exception) {
        log.info("Error");
    }
}
