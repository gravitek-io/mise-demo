package com.demo.helium;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/hello")
public class GreetingResource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        return "Hello from Helium!";
    }

    @GET
    @Path("/info")
    @Produces(MediaType.APPLICATION_JSON)
    public Info info() {
        return new Info(
            "helium",
            System.getProperty("java.version"),
            "1.0.0-SNAPSHOT"
        );
    }

    public record Info(String name, String javaVersion, String version) {}
}
