package pe.upeu.auth.controller;

import pe.upeu.auth.dto.AuthUserDto;
import pe.upeu.auth.entity.AuthUser;
import pe.upeu.auth.entity.TokenDto;
import pe.upeu.auth.service.AuthUserService;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthUserController {
    @Autowired
    AuthUserService authUserService;

    @PostMapping("/login")
    public ResponseEntity<TokenDto> login(@RequestBody AuthUserDto authUserDto) {
        TokenDto tokenDto = authUserService.login(authUserDto);
        if (tokenDto == null)
            return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(tokenDto);
    }

    @PostMapping("/validate")
    public ResponseEntity<TokenDto> validate(@RequestParam String token) {
        TokenDto tokenDto = authUserService.validate(token);
        if (tokenDto == null)
            return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(tokenDto);
    }

    @PostMapping("/create")
    public ResponseEntity<AuthUser> create(@RequestBody AuthUserDto authUserDto) {
        AuthUser authUser = authUserService.save(authUserDto);
        if (authUser == null)
            return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(authUser);
    }

    @GetMapping("/users")
    public ResponseEntity<List<AuthUser>> lista() {
        return ResponseEntity.ok(authUserService.lista());
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<AuthUser> buscarPorId(@PathVariable Integer id) {
        return ResponseEntity.of(authUserService.buscarPorId(id));
    }
}
