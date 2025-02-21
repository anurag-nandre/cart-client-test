package com.twilio.anurag_test;

import com.twilio.cartographer.client.*;
import com.twilio.cartographer.client.impl.ServiceModel;
import com.twilio.cartographer.client.websocket.CartographerServiceDiscoveryListener;

import javax.annotation.Nullable;
import java.util.List;
import java.util.logging.Logger;

import static com.twilio.cartographer.client.CartographerServiceDiscoveryMonitor.HOST_RUNNING;

public class Driver {
    private static final Logger log = Logger.getLogger(Driver.class.getName());
    private final CartographerClient cartClient;
    private final String HOST_SID = "BOXCONFIG_HOST_SID";
    private final String MY_TEST_ROLE = "cacruz-test-role";
    private final String AN_TEST_STACK = "anurag-test-role";


    public void testServiceDiscovery() {
        CartographerServiceDiscoveryMonitor cartListener = new CartographerServiceDiscoveryMonitor(cartClient, AN_TEST_STACK, new CartographerServiceDiscoveryListener() {
            @Override
            public void onChanged(String role, List<ServiceModel> hosts) {
                // The client will be notified of role1 with hosts that are running and located in dev-us1 and the default stack
                System.out.println("Role: " + role + " Hosts: " + hosts);
            }
        }, new ServiceFilter().roleName(AN_TEST_STACK).hostStatus(HOST_RUNNING));

        cartClient.addListener(AN_TEST_STACK, cartListener, new ServiceFilter().realm("dev-us1").stack("default"));
    }
    public Driver(final CartographerClient cartClient) {
        this.cartClient = cartClient;
    }

    public void run() {
        cartClient.start();
        final var filter = new ServiceFilter().realm("dev-us1").stack("default");
        CartographerLoadBalancerMonitor cartMonitor = new CartographerLoadBalancerMonitor(cartClient, System.getenv(HOST_SID));
        TestMonitor testMonitor = new TestMonitor();
        cartMonitor.addListener(testMonitor);

        cartClient.addListener(MY_TEST_ROLE, (final CartEvent event) -> {
            log.fine(() -> show(event));
            cartClient.getServices(filter).forEach((final Service service) -> {
                log.fine(() -> show(service));
            });
        }, filter);

        try{
            testServiceDiscovery();
        } catch (Exception e) {
            log.info("Error in testServiceDiscovery"+e.getMessage());
        }
    }

    private static String show(final CartEvent event) {
        return String.format(
                "CartEvent{type: %s, role: %s, old: %s, new: %s}",
                event.getCartEventType().name(),
                event.getRole(),
                show(event.getOld()),
                show(event.getNew()));
    }

    private static String show(@Nullable final Service service) {
        if (service == null) {
            return "null";
        }
        return String.format(
                "Service{role: %s, host_sid: %s, ip: %s}",
                service.getRole(),
                service.getHostSid(),
                service.getHost().getBasePrivateIp());
    }
}

