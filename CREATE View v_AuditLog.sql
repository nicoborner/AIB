CREATE VIEW v_AuditLog
AS
SELECT 
	Date, 
	UserName, 
	ActionType, 
	ActionFailed, 
	(
		case when DataJson.DeviceName is not null then DataJson.DeviceName else 
		case when DataJson.DeviceName2 is not null then DataJson.DeviceName2 else
		case when DataJson.Name is not null then DataJson.Name else
		case when DataJson.SoftwareLabel is not null then DataJson.SoftwareLabel else
		case when DataJson.NewDevice is not null then DataJson.NewDevice else
		case when DataJson.NewDeviceName is not null then DataJson.NewDeviceName else
		case when DataJson.NewDeviceIdentifier is not null then DataJson.NewDeviceIdentifier else
		''
		end
		end
		end
		end
		end
		end
		end
	) as ResourceName, 
	Data, 
	ErrorMessage,
	Comment
FROM
	UserAction
OUTER APPLY OPENJSON (Data, N'$')
  WITH (
    DeviceName VARCHAR(200) N'$.DeviceName',
    DeviceName2 VARCHAR(200) N'$.Device.Name',
    Name VARCHAR(200) N'$.Name',
    SoftwareLabel VARCHAR(200) N'$.SoftwareLabel',
    NewDevice VARCHAR(200) N'$.NewDevice',
    NewDeviceName VARCHAR(200) N'$.NewDevice.Name',
    NewDeviceIdentifier VARCHAR(200) N'$.NewDeviceIdentifier.Name'
  ) AS DataJson
GO
