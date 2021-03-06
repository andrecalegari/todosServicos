USE [db_servicos]
GO
/****** Object:  StoredProcedure [dbo].[STP_LST_BuscarServicoPorLocalizacao]    Script Date: 27/03/2016 02:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC STP_LST_BuscarServicoPorLocalizacao @latitude = -23.615356306943, @longitude =-46.5392043
CREATE PROCEDURE [dbo].[STP_LST_BuscarServicoPorLocalizacao]
(
	@latitude FLOAT,
	@longitude FLOAT
)

AS BEGIN

SELECT 
	idUsuario,
	latitude,
	longitude
FROM(
	SELECT 
		idUsuario,
		latitude,
		longitude, 
		(6371 *
			acos(
				cos(radians(@latitude)) *
				cos(radians(latitude)) *
				cos(radians(@longitude) - radians(longitude)) +
				sin(radians(@latitude)) *
				sin(radians(latitude))
			 )
		) AS distance
	FROM TB_LocalizacaoUsuario
) result
WHERE distance < 15

END