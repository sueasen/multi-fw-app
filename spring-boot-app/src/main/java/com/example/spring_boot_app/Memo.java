package com.example.spring_boot_app;

import jakarta.persistence.*;
import java.time.Instant;
import lombok.Data;

@Entity
@Table(name = "memos")
@Data
public class Memo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String userId;

    private String title;
    private String content;

    @Column(nullable = false, updatable = false)
    private Instant createdAt = Instant.now();
}