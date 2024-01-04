package com.example.demo.Repository;

import com.example.demo.Domain.Saving;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface SavingRepository extends JpaRepository<Saving, Long> {

    Optional<Saving> findById(Integer id);

    boolean existsById(Integer id);
    void deleteById(Integer id);
}
