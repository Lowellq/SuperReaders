CREATE PROC [dbo].[Monitoring_GetByClassRoom]
@pIdClassRoom AS INT

AS
	BEGIN
	SELECT S.Id,U.FirstName,U.LastName,COUNT(SC.IdStudent) AS ContentRead,SUM(SC.TimeReading)  AS TimeReading,
	(SELECT COUNT(sc.IsFinish)
    FROM  [StudentContent](NOLOCK) SC
	WHERE SC.IdStudent=S.Id AND SC.IsFinish=1) AS ContentFinished --Get the finished content of the student
	,(SELECT COUNT(sc.IsFinish)
    FROM  [StudentContent](NOLOCK) SC
	WHERE SC.IdStudent=S.Id AND SC.IsFinish=0) AS ContentNotFinished --Get the unfinished content of the student
	FROM [User](nolock) AS U
	INNER JOIN [Student](NOLOCK) AS S
	ON S.idUser= U.Id
	INNER JOIN  [ClassRoomDetail](NOLOCK) AS CRD
	ON CRD.IdStudent=S.Id
	INNER JOIN [StudentContent](NOLOCK) SC
	ON SC.IdStudent=S.Id
	WHERE CRD.IdClassRoom=@pIdClassRoom
	group by U.Id,U.FirstName,U.LastName,SC.IdStudent,S.Id
	END