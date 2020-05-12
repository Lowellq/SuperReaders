CREATE PROC [dbo].[Monitoring_GetByStudent]
@pIdStudent AS INT

AS
	BEGIN
	SELECT C.Title,TP.Name,SC.TimeReading,SC.CurrentPage,SC.DateStart,SC.DateFinish,
	SC.IsFinish,
	(SELECT COUNT(SA.Id) FROM [StudentAnswer](NOLOCK) SA
	INNER JOIN [Answer](NOLOCK) AS A
	ON a.Id=sa.IdAnswer
	INNER JOIN [Question](NOLOCK) AS Q
	ON Q.Id=a.IdQuestion
	WHERE A.IsCorrect=1 AND SA.IdStudent=S.Id  AND Q.IdContent=SC.IdContent
	GROUP BY SA.IdStudent) AS Correct,--Get the correct answers for student content
	(SELECT COUNT(SA.Id) FROM [StudentAnswer](NOLOCK) SA
	INNER JOIN [Answer](NOLOCK) AS A
	ON a.Id=sa.IdAnswer
	INNER JOIN [Question](NOLOCK) AS Q
	ON Q.Id=a.IdQuestion
	WHERE A.IsCorrect=0 AND SA.IdStudent=S.Id  AND Q.IdContent=SC.IdContent
	GROUP BY SA.IdStudent) AS Incorrect --Get the wrong answers for student content
	FROM Student AS S
	INNER JOIN StudentContent(NOLOCK) AS SC 
	ON SC.IdStudent=S.Id
	INNER JOIN Content(NOLOCK) AS C
	ON C.Id=SC.IdContent
	inner join TypeContent(NOLOCK) AS TP
	ON Tp.Id=C.IdTypeContent
	WHERE S.Id=@pIdStudent
	GROUP BY S.Id,SC.IdStudent,TP.Id,TP.Name,SC.IdContent,C.Title,
	SC.TimeReading,SC.CurrentPage,SC.DateStart,SC.DateFinish,SC.IsFinish
	END