package com.twilio.anurag_test;

import com.twilio.cartographer.client.CartographerClientImpl;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.logging.Logger;

@SpringBootApplication
public class AnuragTestApplication implements CommandLineRunner {

    private static final Logger log = Logger.getLogger(AnuragTestApplication.class.getName());

    public static void main(String[] args) {
        SpringApplication.run(AnuragTestApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        log.info("Startup");

        final var cartClient = CartographerClientImpl.create();

        final var driver = new Driver(cartClient);

        driver.run();
    }
}
