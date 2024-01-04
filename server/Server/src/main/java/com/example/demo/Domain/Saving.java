package com.example.demo.Domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Saving")
public class Saving {
    @Id
    private Integer id;
    private String name;
    private String category;
    private String initialDate;
    private String endDate;
    private Double totalAmount;
    private Double monthlyAmount;
    private Double savedAmount;

}
