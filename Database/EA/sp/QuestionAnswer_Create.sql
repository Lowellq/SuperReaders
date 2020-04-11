CREATE PROC QuestionAnswer_Create 
@pIdQuestion AS Int, 
@pIdAnswer AS NVARCHAR(50) 
AS
	BEGIN
		INSERT INTO [QuestionAnswer]
		( 
			[IdQuestion], 
			[IdAnswer]
			)
		VALUES
		(
			@pIdQuestion,
			@pIdAnswer
			
		)
	END