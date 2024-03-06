CREATE TABLE IF NOT EXISTS `USER`
(
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    PHONE_NUMBER VARCHAR(10) UNIQUE NOT NULL ,
    USERNAME VARCHAR(255) UNIQUE NOT NULL,
    EMAIL VARCHAR(255) UNIQUE NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL,
    IS_DELETED BOOLEAN NOT NULL DEFAULT 0,
    FULL_NAME VARCHAR(255),
    BIRTH_DATE DATE,
    GENDER VARCHAR(20),
    USER_IMAGE_URL VARCHAR(1000)
    );

CREATE TABLE IF NOT EXISTS `ROLE`
(
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    DESCRIPTION VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS USER_ROLE (
                                         ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                         USER_ID BIGINT,
                                         ROLE_ID BIGINT,

                                         FOREIGN KEY (USER_ID) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (ROLE_ID) REFERENCES Role(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS ADDRESS (
                                       ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       STREET VARCHAR(255) NOT NULL,
    WARD VARCHAR(255) NOT NULL,
    DISTRICT VARCHAR(255) NOT NULL,
    CITY VARCHAR(255) NOT NULL,
    PHONE_NUMBER VARCHAR (10) NOT NULL,
    RECEIVER VARCHAR(255) NOT NULL,
    USER_ID BIGINT NOT NULL,
    IS_DELETED BOOLEAN NOT NULL DEFAULT 0,
    IS_DEFAULT VARCHAR(10) NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USER(ID)
    );

CREATE TABLE IF NOT EXISTS CATEGORY (
                                        ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                        NAME VARCHAR(255) NOT NULL,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1
    );

CREATE TABLE IF NOT EXISTS SUB_CATEGORY (
                                            ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                            NAME VARCHAR(255) NOT NULL,
    CATEGORY_ID BIGINT NOT NULL,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1,
    FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(ID)
    );

CREATE TABLE IF NOT EXISTS PRODUCT (
                                       ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       NAME VARCHAR(255) NOT NULL,
    PRICE BIGINT NOT NULL,
    STOCK INT NOT NULL DEFAULT 50,
    DESCRIPTION TEXT,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1,
    CATEGORY_ID BIGINT NOT NULL,
    SUB_CATEGORY_ID BIGINT NOT NULL,
    FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(ID),
    FOREIGN KEY (SUB_CATEGORY_ID) REFERENCES SUB_CATEGORY(ID)
    );

CREATE TABLE IF NOT EXISTS COLOR (
                                     ID INT AUTO_INCREMENT PRIMARY KEY,
                                     NAME VARCHAR(50) NOT NULL,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1
    );

CREATE TABLE IF NOT EXISTS `SIZE` (
                                      ID INT AUTO_INCREMENT PRIMARY KEY,
                                      NAME VARCHAR(50) NOT NULL,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1
    );


CREATE TABLE IF NOT EXISTS CLASSIFY (
                                        ID INT AUTO_INCREMENT PRIMARY KEY,
                                        NAME VARCHAR(50) NOT NULL,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1
    );

CREATE TABLE IF NOT EXISTS VARIANT (
                                       ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       COLOR_ID INT NOT NULL,
                                       SIZE_ID INT NOT NULL,
                                       CLASSIFY_ID INT NOT NULL,
                                       PRODUCT_ID BIGINT NOT NULL,
                                       IS_SHOWN BOOLEAN NOT NULL DEFAULT 1,
                                       FOREIGN KEY (COLOR_ID) REFERENCES COLOR(ID),
    FOREIGN KEY (SIZE_ID) REFERENCES SIZE(ID),
    FOREIGN KEY (CLASSIFY_ID) REFERENCES CLASSIFY(ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(ID)
    );


CREATE TABLE IF NOT EXISTS PRODUCT_IMAGE (
                                             ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                             URL VARCHAR(255) NOT NULL,
    PRODUCT_ID BIGINT NOT NULL,
    IS_SHOWN BOOLEAN NOT NULL DEFAULT 1,
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(ID)
    );

CREATE TABLE IF NOT EXISTS REVIEW (
                                      ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      CONTENT TEXT NOT NULL,
                                      `TIME` TIMESTAMP NOT NULL,
                                      STAR INT NOT NULL,
                                      USER_ID BIGINT NOT NULL,
                                      PRODUCT_ID BIGINT NOT NULL,
                                      IS_SHOWN BOOLEAN NOT NULL DEFAULT 1,
                                      FOREIGN KEY (USER_ID) REFERENCES USER(ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(ID)
    );

CREATE TABLE IF NOT EXISTS CART (
                                    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    USER_ID BIGINT NOT NULL,
                                    FOREIGN KEY (USER_ID) REFERENCES USER(ID)
    );

CREATE TABLE IF NOT EXISTS CART_ITEM (
                                         ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                         QUANTITY INT NOT NULL,
                                         PRICE BIGINT NOT NULL,
                                         SUBTOTAL BIGINT NOT NULL,
                                         CART_ID BIGINT NOT NULL,
                                         PRODUCT_ID BIGINT NOT NULL,
                                         VARIANT_ID BIGINT NOT NULL,
                                         IS_DELETED BOOLEAN NOT NULL DEFAULT 0,
                                         FOREIGN KEY (CART_ID) REFERENCES CART(ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(ID),
    FOREIGN KEY (VARIANT_ID) REFERENCES VARIANT(ID)
    );

CREATE TABLE IF NOT EXISTS ORDERS (
                                      ID BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      `DATE` TIMESTAMP NOT NULL,
                                      PAYMENT VARCHAR(255) NOT NULL,
    TOTAL_COST BIGINT NOT NULL,
    TRANSPORT INT NOT NULL,
    `TOTAL_PAYMENT` BIGINT NOT NULL,

    ADDRESS_ID BIGINT NOT NULL,
    USER_ID BIGINT NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USER(ID),
    FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ID)
    );