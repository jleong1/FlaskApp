DROP DATABASE IF EXISTS FeelsApp;
CREATE DATABASE FeelsApp;
USE FeelsApp;

    CREATE TABLE tbl_User (
        `user_id` bigint NOT NULL AUTO_INCREMENT,
        `user_name` varchar(225) NOT NULL,
        `user_username` varchar(225) NOT NULL,  ##varchar 225 crucial due to having it hashed later on for security reasons.
        `user_password` varchar(225) NOT NULL,
        PRIMARY KEY (`user_id`)
        );

            ALTER TABLE tbl_User AUTO_INCREMENT = 1;
            ##Ensures that user ID's start from 1.

            ##  sp_createUser - STORED PROCEDURE - to check if user/username already exists.
            DELIMITER $$
            CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
                IN p_name varchar(225),
                IN p_username varchar(225),
                IN p_password varchar(225)
                )
                BEGIN
                    if ( select exists (select 1 from tbl_user where user_username = p_username) ) THEN
                     
                        select 'Username Exists !!';
                     
                ELSE
                 
                    insert into tbl_user
                    (
                        user_name,
                        user_username,
                        user_password
                    )
                    values
                    (
                        p_name,
                        p_username,
                        p_password
                    );
                 
                END IF;
            END$$
            DELIMITER ; 
        ##Sp_Check Dup user


            ##  sp_validateLogin - STORED PROCEDURE - to get user details based on username.
            DELIMITER $$
            CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateLogin`(
            IN p_username varchar(20)
            )
            BEGIN
                select * from tbl_user where user_username = p_username;
            END$$
            DELIMITER ;

    Create Table tbl_UltCat (
        `c1_id` int NOT NULL,
        `c1_name` varchar(45) NOT NULL,
        PRIMARY KEY(`c1_id`)
        );
        ##Popluation
            Insert into tbl_UltCat value (1, 'admiration');
            Insert into tbl_UltCat value (2, 'rage');
            Insert into tbl_UltCat value (3, 'grief');
            Insert into tbl_UltCat value (4, 'feelings');

    Create Table tbl_SubCat(
        `c1_id` int references tbl_UltCat,
        `c1_name` varchar(45) references tbl_UltCat,
        `c2_id` int NOT NULL, 
        `c2_name` varchar(45) NOT NULL,
        PRIMARY KEY(`c1_id`,`c2_id`)
        );
        ##Popluation
            Insert into tbl_SubCat value (1, 'admiration', 1, 'alive');
            Insert into tbl_SubCat value (1, 'admiration', 2, 'happy');
            Insert into tbl_SubCat value (1, 'admiration', 3, 'interested');
            Insert into tbl_SubCat value (1, 'admiration', 4, 'loving');
            Insert into tbl_SubCat value (1, 'admiration', 5, 'open');
            Insert into tbl_SubCat value (1, 'admiration', 6, 'positive');
            Insert into tbl_SubCat value (1, 'admiration', 7, 'testing');

            Insert into tbl_SubCat value (2, 'rage', 1, 'angry');
            Insert into tbl_SubCat value (2, 'rage', 2, 'confused');
            Insert into tbl_SubCat value (2, 'rage', 3, 'depressed');
            Insert into tbl_SubCat value (2, 'rage', 4, 'judgemental');
            Insert into tbl_SubCat value (2, 'rage', 5, 'testing');

            Insert into tbl_SubCat value (3, 'grief', 1, 'afraid');
            Insert into tbl_SubCat value (3, 'grief', 2, 'helpless');
            Insert into tbl_SubCat value (3, 'grief', 3, 'hurt');
            Insert into tbl_SubCat value (3, 'grief', 4, 'indifferent');
            Insert into tbl_SubCat value (3, 'grief', 5, 'sad');
            Insert into tbl_SubCat value (3, 'grief', 6, 'testing');

            Insert into tbl_SubCat value (4, 'feelings', 1, 'peaceful');
            Insert into tbl_SubCat value (4, 'feelings', 2, 'relaxed');
            Insert into tbl_SubCat value (4, 'feelings', 3, 'strong');
            Insert into tbl_SubCat value (4, 'feelings', 4, 'testing');
            ##added testing, set for localhost testings.

    Create Table tbl_Emots(        
        `Emot_id` int NOT NULL,
        `Emot_name` varchar(45) NOT NULL,
        `c2_id` bigint references tbl_SubCat,
        `c2_name` varchar(45) references tbl_SubCat,
        PRIMARY KEY(`Emot_id`)
        );

    Create Table tbl_ChTn(
        `Chtn_id` bigint NOT NULL, 
        `Chtn_name` varchar(45) NOT NULL,
        `Chtn_url` varchar(100) NOT NULL,
        `Emot_id` bigint references tbl_Emots,
        `Emot_name` varchar(45) references tbl_Emots,
        PRIMARY KEY(`Chtn_id`)
        );