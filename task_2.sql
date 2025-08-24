-- task_2.sql
-- Creates all tables for the alx_book_store schema

CREATE DATABASE IF NOT EXISTS alx_book_store
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE alx_book_store;

-- AUTHORS
CREATE TABLE IF NOT EXISTS `AUTHORS` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(215) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- BOOKS
CREATE TABLE IF NOT EXISTS `BOOKS` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(130) NOT NULL,
  `author_id` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `publication_date` DATE NULL,
  PRIMARY KEY (`book_id`),
  INDEX `idx_books_author_id` (`author_id`),
  CONSTRAINT `fk_books_authors`
    FOREIGN KEY (`author_id`) REFERENCES `AUTHORS` (`author_id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- CUSTOMERS
CREATE TABLE IF NOT EXISTS `CUSTOMERS` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(215) NOT NULL,
  `email` VARCHAR(215) NOT NULL,
  `address` TEXT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ORDERS
CREATE TABLE IF NOT EXISTS `ORDERS` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `idx_orders_customer_id` (`customer_id`),
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMERS` (`customer_id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ORDER_DETAILS
CREATE TABLE IF NOT EXISTS `ORDER_DETAILS` (
  `orderdetailid` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` DOUBLE NOT NULL,
  PRIMARY KEY (`orderdetailid`),
  INDEX `idx_order_details_order_id` (`order_id`),
  INDEX `idx_order_details_book_id` (`book_id`),
  CONSTRAINT `fk_order_details_orders`
    FOREIGN KEY (`order_id`) REFERENCES `ORDERS` (`order_id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `fk_order_details_books`
    FOREIGN KEY (`book_id`) REFERENCES `BOOKS` (`book_id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
