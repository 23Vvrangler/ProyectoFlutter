package com.example.ms_auth.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ms_auth.entity.Role;
import com.example.ms_auth.services.RoleService;

@RestController
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleService roleService;

    @GetMapping("/list")
    ResponseEntity<List<Role>> listar() {
        return ResponseEntity.ok(roleService.listar());
    }
    @PostMapping("/create-role")
    ResponseEntity<Role> guardar(Role role) {
        return ResponseEntity.ok(roleService.guardar(role));
    }
    @GetMapping("/{id}")
    ResponseEntity<Role> buscarPorId(Integer id) {
        return ResponseEntity.ok(roleService.buscarPorId(id).get());
    }
    @PostMapping("/update-role")
    ResponseEntity<Role> actualizar(Role role) {
        return ResponseEntity.ok(roleService.actualizar(role));
    }
    @PostMapping("/{id}")
    public ResponseEntity<List<Role>> eliminar(Integer id) {
        roleService.eliminar(id);
        return ResponseEntity.ok(roleService.listar());
    }
}
