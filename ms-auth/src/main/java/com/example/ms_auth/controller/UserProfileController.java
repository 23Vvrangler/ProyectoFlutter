package com.example.ms_auth.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ms_auth.entity.UserProfile;
import com.example.ms_auth.services.UserProfileService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/user-profile")
public class UserProfileController {
    @Autowired
    UserProfileService userProfileService;

    @GetMapping("/list")
    ResponseEntity<List<UserProfile>> listar(){
        return ResponseEntity.ok(userProfileService.listar());
    }
    @PostMapping("/create-profile")
        ResponseEntity<UserProfile> guardar(@RequestBody UserProfile userProfile) {
        return ResponseEntity.ok(userProfileService.guardar((userProfile)));
    }
    @GetMapping("/{id}")
    ResponseEntity<UserProfile> buscarPorId(@PathVariable(required = true) Integer id){
        return ResponseEntity.ok(userProfileService.buscarPorId(id).get());

    }
    @PutMapping("/update-profile")
    ResponseEntity<UserProfile> actualizar(@RequestBody UserProfile userProfile){
        return ResponseEntity.ok(userProfileService.actualizar((userProfile)));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<List<UserProfile>> eliminar(@PathVariable(required = true) Integer id){
       userProfileService.eliminar(id);
        return ResponseEntity.ok(userProfileService.listar());

    }
}