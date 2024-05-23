USE BD;
GO

-- ������� ������-����
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongMasterKeyPassword!';
GO

-- ������� ����������
CREATE CERTIFICATE PasswordCert
    WITH SUBJECT = 'Password Encryption Certificate';
GO

-- ������� ������������ ����, ���������� ������������
CREATE SYMMETRIC KEY PasswordKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE PasswordCert;
GO

-- ������� ������
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

-- ��������� ������������ ����
OPEN SYMMETRIC KEY PasswordKey
    DECRYPTION BY CERTIFICATE PasswordCert;
GO

-- ������ ��� ��������� ������ � ��������������� ��������
SELECT 
    Username,
    CAST(DECRYPTBYKEY(Password) AS NVARCHAR(MAX)) AS DecryptedPassword
FROM Users;
GO

-- ��������� ������������ ����
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