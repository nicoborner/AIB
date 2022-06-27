
-- Add NumberOfStagingSlots column to DeviceType table
ALTER TABLE DeviceType
ADD NumberOfStagingSlots INT
GO

-- Insert global setting NumberOfStagingSlots into Setting table
INSERT INTO Setting (Name, Value) VALUES('NumberOfStagingSlots', NULL)

--
-- Permissions --
--

DECLARE @GetStagingSlotValidationErrors NVARCHAR(MAX) = 'GetStagingSlotValidationErrors'
DECLARE @Audit_Index NVARCHAR(MAX) = 'Audit_Index'
DECLARE @ListAudit NVARCHAR(MAX) = 'ListAudit'
DECLARE @RoleNameAdministrator NVARCHAR(MAX) = 'Administrator'
DECLARE @RoleNameSupporter NVARCHAR(MAX) = 'Supporter'

-- Inserting new permission
INSERT INTO Permission( Name, Type, Description) VALUES (@GetStagingSlotValidationErrors, 1, NULL)
INSERT INTO Permission( Name, Type, Description) VALUES (@Audit_Index, 2, NULL)
INSERT INTO Permission( Name, Type, Description) VALUES (@ListAudit, 1, NULL)

-- Add the new permission to the Admin role
INSERT INTO RolePermission (RoleID, PermissionID) VALUES ((SELECT ID FROM Role WHERE Name = @RoleNameAdministrator), (SELECT ID FROM Permission WHERE Name = @GetStagingSlotValidationErrors))
INSERT INTO RolePermission (RoleID, PermissionID) VALUES ((SELECT ID FROM Role WHERE Name = @RoleNameAdministrator), (SELECT ID FROM Permission WHERE Name = @Audit_Index))
INSERT INTO RolePermission (RoleID, PermissionID) VALUES ((SELECT ID FROM Role WHERE Name = @RoleNameAdministrator), (SELECT ID FROM Permission WHERE Name = @ListAudit))

-- Add the new permission to the Support role
INSERT INTO RolePermission (RoleID, PermissionID) VALUES ((SELECT ID FROM Role WHERE Name = @RoleNameSupporter), (SELECT ID FROM Permission WHERE Name = @GetStagingSlotValidationErrors))

--
-- Revision --
--

-- Insert revision number
INSERT INTO Revision(Date, RevisionNumber) values ('20220125', 145)
GO
