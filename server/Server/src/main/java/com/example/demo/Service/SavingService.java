package com.example.demo.Service;

import com.example.demo.Domain.Saving;
import com.example.demo.Repository.SavingRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
public class SavingService {
    @Autowired
    private SavingRepository savingRepository;

    public List<Saving> getAllSavings() {
        return savingRepository.findAll();
    }

    public Saving getSavingById(Integer id) {
        Optional<Saving> saving = savingRepository.findById(id);
        if (saving.isEmpty()) {
            throw new RuntimeException("Error on get by id!");
        }
        return saving.get();
    }

    public Saving createSaving(Saving saving) {
        if (savingRepository.existsById(saving.getId()))
            throw new RuntimeException("Saving already exists!");

        return savingRepository.save(saving);
    }

    public Saving updateSaving(Saving updatedSaving) {
        if(!savingRepository.existsById(updatedSaving.getId())){
            throw new RuntimeException("Saving doesn't exists!");
        }
        return savingRepository.save(updatedSaving);
    }

    @Transactional
    public void deleteSaving(Integer id) {
        if (!savingRepository.existsById(id)) {
            throw new RuntimeException("Error on delete!");
        }
        savingRepository.deleteById(id);
    }
}
