package com.shopee.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "CART")
public class Cart {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "ID")
   private long id;

   @OneToOne
   @JoinColumn(name = "USER_ID")
   private User user;

   @OneToMany(mappedBy = "cart", fetch = FetchType.LAZY)
   private List<CartItem> cartItemList ;
}
