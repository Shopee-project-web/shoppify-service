package com.shoppify.repository;

import com.shoppify.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<Role, Long> {
   Role findByName(String name);


}
