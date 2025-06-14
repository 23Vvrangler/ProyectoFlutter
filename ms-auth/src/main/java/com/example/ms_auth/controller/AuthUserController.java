package com.example.ms_auth.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.ms_auth.dto.AuthUserDto;
import com.example.ms_auth.entity.AuthUser;
import com.example.ms_auth.entity.TokenDto;
import com.example.ms_auth.services.AuthUserService;


@RestController
@RequestMapping("/auth")
public class AuthUserController {
    @Autowired
    AuthUserService AuthuserService;

    @PostMapping("/login")
    public ResponseEntity<TokenDto> login(@RequestBody AuthUserDto AuthuserDto) {
        TokenDto tokenDto = AuthuserService.login(AuthuserDto);
        if (tokenDto == null)
            return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(tokenDto);
    }

    @PostMapping("/validate")
    public ResponseEntity<TokenDto> validate(@RequestParam String token) {
        TokenDto tokenDto = AuthuserService.validate(token);
        if (tokenDto == null)
            return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(tokenDto);
    }

    @PostMapping("/create")
    public ResponseEntity<AuthUser> create(@RequestBody AuthUserDto AuthuserDto) {
        AuthUser Authuser = AuthuserService.save(AuthuserDto);
        if (Authuser == null)
            return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(Authuser);
    }

    @GetMapping("/users")
    public ResponseEntity<List<AuthUser>> lista() {
        return ResponseEntity.ok(AuthuserService.lista());
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<AuthUser> buscarPorId(@PathVariable Integer id) {
        return ResponseEntity.of(AuthuserService.buscarPorId(id));
    }
}