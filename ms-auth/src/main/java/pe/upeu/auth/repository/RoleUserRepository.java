package pe.upeu.auth.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pe.upeu.auth.entity.RoleUser;

@Repository
public interface RoleUserRepository extends JpaRepository<RoleUser, Integer>{
    
}