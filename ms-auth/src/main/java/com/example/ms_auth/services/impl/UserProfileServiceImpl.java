package com.example.ms_auth.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ms_auth.entity.UserProfile;
import com.example.ms_auth.repository.UserProfileRepository;
import com.example.ms_auth.services.UserProfileService;

@Service
public class UserProfileServiceImpl implements UserProfileService {
    @Autowired
    private UserProfileRepository userProfileRepository;
    @Override
    public List<UserProfile> listar() {
        return userProfileRepository.findAll();
    }
    @Override
    public UserProfile guardar(UserProfile userProfile) {
        return userProfileRepository.save(userProfile);
    }
    @Override
    public Optional<UserProfile> buscarPorId(Integer id) {
        return userProfileRepository.findById(id); 
    }
    @Override
    public UserProfile actualizar(UserProfile userProfile) {
        return userProfileRepository.save(userProfile);
    }
    @Override
    public void eliminar(Integer id) {
        userProfileRepository.deleteById(id);
    }
}