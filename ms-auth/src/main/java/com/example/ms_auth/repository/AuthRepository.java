package com.example.ms_auth.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.ms_auth.entity.Authuser;

@Repository
public interface AuthRepository extends JpaRepository<Authuser, Integer> {
    Optional<Authuser> findByUserName(String userName);
}
