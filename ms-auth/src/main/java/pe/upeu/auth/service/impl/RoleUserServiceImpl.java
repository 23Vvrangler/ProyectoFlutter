package pe.upeu.auth.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pe.upeu.auth.entity.RoleUser;
import pe.upeu.auth.repository.RoleUserRepository;
import pe.upeu.auth.service.RoleUserService;

@Service
public class RoleUserServiceImpl implements RoleUserService {
    @Autowired
    private RoleUserRepository roleUserRepository;
    
    @Override
    public List<RoleUser> listar(){
      return roleUserRepository.findAll();  
    }
    @Override
    public RoleUser guardar(RoleUser roleUser) {
        return roleUserRepository.save(roleUser);
    }
    @Override
    public Optional<RoleUser> buscarPorId(Integer id) {
        return roleUserRepository.findById(id);
    }

    @Override
    public RoleUser actualizar(RoleUser roleUser) {
        return roleUserRepository.save(roleUser);
    }

    @Override
    public void eliminar(Integer id) {
        roleUserRepository.deleteById(id);

    }
}
