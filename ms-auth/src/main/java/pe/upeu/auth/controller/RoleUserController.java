package pe.upeu.auth.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import pe.upeu.auth.entity.RoleUser;
import pe.upeu.auth.service.RoleUserService;

@RestController
@RequestMapping("/role-user")
public class RoleUserController {
    @Autowired
    private RoleUserService roleUserService;

    @GetMapping
    ResponseEntity<List<RoleUser>> listar(){
        return ResponseEntity.ok(roleUserService.listar());
    }
    @PostMapping
    ResponseEntity<RoleUser> guardar(@RequestBody RoleUser roleUser){
        return ResponseEntity.ok(roleUserService.guardar((roleUser)));
    }

    @GetMapping("/{id}")
    ResponseEntity<RoleUser> buscarPorId(@PathVariable(required = true) Integer id){
        return ResponseEntity.ok(roleUserService.buscarPorId(id).get());

    }

    @PutMapping
    ResponseEntity<RoleUser> actualizar(@RequestBody RoleUser roleUser){
        return ResponseEntity.ok(roleUserService.actualizar((roleUser)));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<List<RoleUser>> eleminar(@PathVariable(required = true) Integer id){
        roleUserService.eliminar(id);
        return ResponseEntity.ok(roleUserService.listar());

    }
}
