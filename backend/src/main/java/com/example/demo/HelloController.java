package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HelloController {

    // Allows your React frontend to securely talk to this API without security blocks
    @CrossOrigin(origins = "*") 
    @GetMapping("/api/hello")
    public Map<String, String> sayHello() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "You successfully created EKS and running the application!");
        response.put("status", "Success");
        return response; 
    }
}