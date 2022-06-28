DECLARE @RoleName NVARCHAR(MAX) = 'ROLENAME'

DECLARE @PermissionGetStagingSlotValidationErrors NVARCHAR(MAX) = 'GetStagingSlotValidationErrors'
DECLARE @PermissionRegisterDeviceClientActionCommand NVARCHAR(MAX) = 'RegisterDeviceClientActionCommand'
DECLARE @PermissionGetDeviceClientActionCommand NVARCHAR(MAX) = 'GetDeviceClientActionCommand'

DECLARE @RoleId INT = (SELECT Id FROM [dbo].[Role] WHERE Name = @RoleName);

DECLARE @PermissionId INT = (SELECT ID FROM [dbo].[Permission] WHERE Name = @PermissionRegisterDeviceClientActionCommand);
IF (SELECT PermissionID FROM [dbo].[RolePermission] WHERE PermissionID = @PermissionId AND RoleID = @RoleId) IS NULL
	INSERT INTO[dbo].[RolePermission] (PermissionID, RoleID) VALUES (@PermissionId, @RoleId);

SET @PermissionId = (SELECT ID FROM [dbo].[Permission] WHERE Name = @PermissionGetDeviceClientActionCommand);
IF (SELECT PermissionID FROM [dbo].[RolePermission] WHERE PermissionID = @PermissionId AND RoleID = @RoleId) IS NULL
	INSERT INTO [dbo].[RolePermission] (PermissionID, RoleID) VALUES (@PermissionId, @RoleId);

SET @PermissionId = (SELECT ID FROM [dbo].[Permission] WHERE Name = @PermissionGetStagingSlotValidationErrors);
IF (SELECT PermissionID FROM [dbo].[RolePermission] WHERE PermissionID = @PermissionId AND RoleID = @RoleId) IS NULL
	INSERT INTO [dbo].[RolePermission] (PermissionID, RoleID) VALUES (@PermissionId, @RoleId);
