package com.example.ms_auth.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.ms_auth.entity.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
}