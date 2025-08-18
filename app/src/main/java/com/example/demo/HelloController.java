package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HelloController {

  @GetMapping("/")
  public Map<String, String> hello() {
    return Map.of(
        "status", "ok",
        "service", "demo",
        "message", "Hello from Jenkins CI/CD!"
    );
  }
}
