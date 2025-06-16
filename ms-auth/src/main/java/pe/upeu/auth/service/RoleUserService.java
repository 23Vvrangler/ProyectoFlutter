package pe.upeu.auth.service;

import java.util.List;
import java.util.Optional;

import pe.upeu.auth.entity.RoleUser;

public interface RoleUserService {
    List<RoleUser> listar();
    RoleUser guardar(RoleUser roleUser);
    Optional<RoleUser> buscarPorId(Integer id);
    RoleUser actualizar(RoleUser roleUser);
    void eliminar(Integer id);
}