USE BD;
GO

-- Создаем мастер-ключ
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongMasterKeyPassword!';
GO

-- Создаем сертификат
CREATE CERTIFICATE PasswordCert
    WITH SUBJECT = 'Password Encryption Certificate';
GO

-- Создаем симметричный ключ, защищенный сертификатом
CREATE SYMMETRIC KEY PasswordKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE PasswordCert;
GO

-- Шифруем пароли
OPEN SYMMETRIC KEY PasswordKey
    DECRYPTION BY CERTIFICATE PasswordCert;

UPDATE Users
SET Password = ENCRYPTBYKEY(KEY_GUID('PasswordKey'), Password);
GO

CLOSE SYMMETRIC KEY PasswordKey;
GO
select * from Users


USE BD;
GO

-- Открываем симметричный ключ
OPEN SYMMETRIC KEY PasswordKey
    DECRYPTION BY CERTIFICATE PasswordCert;
GO

-- Запрос для получения данных с расшифрованными паролями
SELECT 
    Username,
    CAST(DECRYPTBYKEY(Password) AS NVARCHAR(MAX)) AS DecryptedPassword
FROM Users;
GO

-- Закрываем симметричный ключ
CLOSE SYMMETRIC KEY PasswordKey;
GO

BACKUP DATABASE BD
TO DISK = 'X:\BD.bak'
WITH FORMAT,
MEDIANAME = 'SQLServerBackups',
NAME = 'Full Backup of BD';
GO

RESTORE DATABASE BD
FROM DISK = 'X:\BD.bak'
WITH REPLACE;
GO