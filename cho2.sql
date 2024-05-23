-- Создаем базу данных для хранения пользователей и их паролей
CREATE DATABASE BD;
GO

USE BD;
GO

-- Создаем таблицу Users для хранения пользователей и их паролей
CREATE TABLE Users (
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL
);
GO

-- Процедура для генерации случайных паролей и создания пользователей, баз данных и настройки прав доступа
CREATE PROCEDURE CreateUsersAndDatabases
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @username NVARCHAR(50);
    DECLARE @password NVARCHAR(50);
    DECLARE @dbname NVARCHAR(50);
    DECLARE @sql NVARCHAR(MAX);

    WHILE @i <= 10
    BEGIN
        SET @username = 'user' + CAST(@i AS NVARCHAR(50));
        SET @password = (
            SELECT SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 0, 4) +
                   SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 0, 3)
        );
        SET @dbname = 'BD' + CAST(@i AS NVARCHAR(50));

        -- Создаем пользователя
        SET @sql = 'CREATE LOGIN ' + @username + ' WITH PASSWORD = ''' + @password + ''';';
        EXEC sp_executesql @sql;

        -- Создаем базу данных
        SET @sql = 'CREATE DATABASE ' + @dbname + ';';
        EXEC sp_executesql @sql;

        -- Создаем пользователя в базе данных
        SET @sql = 'USE ' + @dbname + '; CREATE USER ' + @username + ' FOR LOGIN ' + @username + ';';
        EXEC sp_executesql @sql;

        -- Назначаем права доступа
        SET @sql = 'USE ' + @dbname + '; ALTER ROLE db_owner ADD MEMBER ' + @username + ';';
        EXEC sp_executesql @sql;

        -- Заполняем таблицу Users данными
        INSERT INTO Users (Username, Password) VALUES (@username, @password);

        SET @i = @i + 1;
    END
END
GO

-- Выполняем процедуру для создания пользователей, баз данных и настройки прав доступа
EXEC CreateUsersAndDatabases;
GO

-- Удаляем процедуру после завершения всех операций, если это необходимо
DROP PROCEDURE CreateUsersAndDatabases;

use master 
drop database BD
drop database BD1
drop database BD2
drop database BD3
drop database BD4
drop database BD5
drop database BD6
drop database BD7
drop database BD8
drop database BD9
drop database BD10


drop login user1
drop login user2
drop login user3
drop login user4
drop login user5
drop login user6
drop login user7
drop login user8
drop login user9
drop login user10