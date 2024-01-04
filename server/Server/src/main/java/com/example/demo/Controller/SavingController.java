package com.example.demo.Controller;

import com.example.demo.Domain.Saving;
import com.example.demo.Service.SavingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/saving")
public class SavingController {

    @Autowired
    private SavingService savingService;

    @GetMapping
    public ResponseEntity<List<Saving>> getAllSavings() {
        List<Saving> savings=savingService.getAllSavings();
        System.out.println("Successfully found all!");
        return new ResponseEntity<>(savings, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Saving> getSavingById(@PathVariable Integer id) {
        Saving saving=savingService.getSavingById(id);
        System.out.println("Successfully found: "+saving.getName()+"!");
        return ResponseEntity.ok(saving);
    }

    @PostMapping
    public ResponseEntity<Saving> createSaving(@RequestBody Saving newSaving) {
        Saving saving = savingService.createSaving(newSaving);
        System.out.println("Successfully creation: "+saving.getName()+"!");
        return new ResponseEntity<>(saving, HttpStatus.CREATED);
    }

    @PutMapping()
    public ResponseEntity<Saving> updateSaving( @RequestBody Saving updatedSaving) {
        Saving saving=savingService.updateSaving(updatedSaving);
        System.out.println("Successfully updated!");
        return new ResponseEntity<>(saving, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSaving(@PathVariable Integer id) {
        savingService.deleteSaving(id);
        System.out.println("Successfully deleted!");
        return new ResponseEntity<>( HttpStatus.OK);
    }
}