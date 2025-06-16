package pe.upeu.auth.service;

import java.util.List;
import java.util.Optional;

import pe.upeu.auth.dto.AuthUserDto;
import pe.upeu.auth.entity.AuthUser;
import pe.upeu.auth.entity.TokenDto;

public interface AuthUserService {

    AuthUser save(AuthUserDto authUserDto);
    TokenDto login(AuthUserDto authUserDto);
    TokenDto validate(String token);

    List<AuthUser> lista();
    Optional<AuthUser> buscarPorId(Integer id);
}
