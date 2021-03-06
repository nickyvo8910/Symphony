USE [master]
GO
Create database  SymphonyLtd
GO
USE [SymphonyLtd]
GO
/****** Object:  StoredProcedure [dbo].[AddAdminClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[AddAdminClass]
@ClassID varchar(50),
@entranceID varchar(50),
@startDate datetime

as
begin
insert into tblClass(classID,entranceID,startDate) values(@ClassID,@entranceID,@startDate)
end
GO
/****** Object:  StoredProcedure [dbo].[AddAdminCourse]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AddAdminCourse]
	@courseID varchar(50),
	@courseName varchar(50),
	@courseFee decimal
as
begin

insert into tblCourse(courseID,courseName,courseFee) values (@courseID,@courseName,@courseFee)
end
GO
/****** Object:  StoredProcedure [dbo].[AddAdminEntrances]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------

Create procedure [dbo].[AddAdminEntrances]
	@entranceID varchar(50),
	@entranceFee float,
	@courseID varchar(50),
	@entranceTitle varchar(50),
	@entranceDate datetime,
	@startDate datetime,
	@endDate datetime

as
begin
insert into tblEntrance(entranceID,entranceFee,courseID,entranceTitle,entranceDate,startDate,endDate)
values (@entranceID,@entranceFee,@courseID,@entranceTitle,@entranceDate,@startDate,@endDate)
end

---------------------

GO
/****** Object:  StoredProcedure [dbo].[AddAdminTopic]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[AddAdminTopic]
@topicID varchar(50),
@courseID varchar(50),
@topicDes varchar(50),
@topicName varchar(50)
as
begin
insert into tblTopic(topicID,courseID,topicName,topicDes) values(@topicID,@courseID,@topicName,@topicDes)
end
GO
/****** Object:  StoredProcedure [dbo].[addFeedback]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addFeedback]
@mail varchar(50),
@mess varchar(max)
as
begin 
insert into tblFAQ(faqEmail,faqQuestion) values(@mail,@mess)
end
GO
/****** Object:  StoredProcedure [dbo].[BankchkBalance]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BankchkBalance]
@accID int
as
begin
	select Balance from tblBank where AccountID =@accID
end
GO
/****** Object:  StoredProcedure [dbo].[Bankdeposit]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Bankdeposit]
@accTo int,
@Amount money
as
begin
	update tblBank set Balance += @Amount where AccountID = @accTo
end
GO
/****** Object:  StoredProcedure [dbo].[BankPayPayment]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BankPayPayment]
  @payID varchar(50),
  @payAcc varchar(50),
  @payDate date
as
begin
if(select tblPayment.payAmount from tblPayment where payID =@payID) =1000
begin
update tblPayment set AccID=@payAcc,payDate=@payDate,[is Paid]='Paid',payType='Transfer' where payID=@payID 
update tblUser set practiceSession =1 where tblUser.userID = (select tblPayment.userID from tblPayment where payID =@payID)
end
else if (select tblPayment.payAmount from tblPayment where payID =@payID) =1500
begin
update tblPayment set AccID=@payAcc,payDate=@payDate,[is Paid]='Paid',payType='Transfer' where payID=@payID 
update tblUser set practiceSession =1 where tblUser.userID = (select tblPayment.userID from tblPayment where payID =@payID)
end
else
begin
update tblPayment set AccID=@payAcc,payDate=@payDate,[is Paid]='Paid',payType='Transfer' where payID=@payID 
end
end
GO
/****** Object:  StoredProcedure [dbo].[Bankwithdraw]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Bankwithdraw]
@accFrom int,
@Amount money
as
begin
	update tblBank set Balance -= @Amount where AccountID = @accFrom
end
GO
/****** Object:  StoredProcedure [dbo].[chkAddClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[chkAddClass]
@entranceID varchar(50)
as
begin
select count(*) from tblClass  where entranceID=@entranceID
end

GO
/****** Object:  StoredProcedure [dbo].[chkHasClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[chkHasClass]
@entranceID varchar(50)
as
begin
select count(*) from tblClass where entranceID =@entranceID
end
GO
/****** Object:  StoredProcedure [dbo].[chkPKClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[chkPKClass]
@classID varchar(50)
as
begin
select count(*) from tblClass where tblClass.classID = @classID
end
GO
/****** Object:  StoredProcedure [dbo].[chkPKCourse]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[chkPKCourse]
@id varchar(50)
as
begin
select count(*) from tblCourse where tblCourse.courseID = @id
end

GO
/****** Object:  StoredProcedure [dbo].[chkPKEntrances]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[chkPKEntrances]
@id varchar(50)
as
begin
select count(*) from tblEntrance where tblEntrance.entranceID = @id
end

GO
/****** Object:  StoredProcedure [dbo].[chkPKTopic]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[chkPKTopic]
@id varchar(50)
as
begin
select count(*) from tblTopic where tblTopic.topicID = @id
end

GO
/****** Object:  StoredProcedure [dbo].[chkRegUser]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[chkRegUser]
@id varchar(50)
as
begin
select count(*) from tblUser where tblUser.userID =@id
end
GO
/****** Object:  StoredProcedure [dbo].[chkUserClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[chkUserClass]
@id varchar(50)
as
begin
select count(*) from tblUser where tblUser.userID =@id and classID is null
end
GO
/****** Object:  StoredProcedure [dbo].[chkUserConfirmClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[chkUserConfirmClass]
@userID varchar(50)
as
if (select tblUser.entranceMark from tblUser where tblUser.userID =@userID) >= 50
begin
select count(*) from tblPayment left join tblUser on tblPayment.userID = tblUser.userID
right join tblClass on tblPayment.classID = tblClass.classID 
right join tblEntrance on tblClass.entranceID = tblEntrance.entranceID
right join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblUser.userID=@userID and tblPayment.payAmount =tblCourse.courseFee
end
else 
begin
select count(*) from tblPayment left join tblUser on tblPayment.userID = tblUser.userID
right join tblClass on tblPayment.classID = tblClass.classID 
right join tblEntrance on tblClass.entranceID = tblEntrance.entranceID
right join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblUser.userID=@userID and tblPayment.payAmount =tblCourse.courseFee + 1725
end
GO
/****** Object:  StoredProcedure [dbo].[chkUserPrac]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[chkUserPrac]
@id varchar(50)
as
begin
if (select tblUser.practiceSession from tblUser where tblUser.userID =@id )is not null
begin
select tblUser.practiceSession from tblUser where tblUser.userID =@id
end
else
begin
select 0
end
end
GO
/****** Object:  StoredProcedure [dbo].[chkUserRegPrac]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[chkUserRegPrac]
@userID varchar(50)
as
begin
select count(*) from tblPayment left join tblUser on tblPayment.userID = tblUser.userID
right join tblClass on tblPayment.classID = tblClass.classID 
right join tblEntrance on tblClass.entranceID = tblEntrance.entranceID
right join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblUser.userID=@userID and (tblPayment.payAmount =1000 or tblPayment.payAmount=1500)
end
GO
/****** Object:  StoredProcedure [dbo].[delAdminRS]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delAdminRS]
@userid  varchar(50) 
AS 
BEGIN 
update tblUser set entranceMark = null where userID =@userid
END

GO
/****** Object:  StoredProcedure [dbo].[delCenter]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delCenter]
@delCenter varchar(50) 
AS 
BEGIN 
DELETE FROM tblCenter WHERE centerID=@delCenter ;
END

GO
/****** Object:  StoredProcedure [dbo].[delClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[delClass]
@id varchar(50)
as
begin
delete from tblPayment where userID in(
select userID from tblUser where classID =@id
)
update tblUser set classID=null,entranceMark=null,practiceSession=null where userID in(
select userID from tblUser where classID =@id)
delete from tblClass where classID =@id
end

GO
/****** Object:  StoredProcedure [dbo].[delEntrance]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[delEntrance]
@delEntrance varchar(50)
as
begin
delete from tblPayment where userID in(
select userID from tblUser where classID in (
select classID from tblClass where entranceID =@delEntrance
))
update tblUser set classID=null,entranceMark=null,practiceSession=null where userID in(
select userID from tblUser where classID in (
select classID from tblClass where entranceID=@delEntrance))
delete from tblClass where classID in (
select classID from tblClass where entranceID=@delEntrance)
delete from tblEntrance where entranceID =@delEntrance
end



GO
/****** Object:  StoredProcedure [dbo].[DeleteAdminCourse]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create procedure [dbo].[DeleteAdminCourse] @id varchar(50) as begin delete from tblPayment where userID in( select userID from tblUser where classID in ( select classID from tblClass where entranceID in ( select entranceID from tblEntrance where courseID =@id))) update tblUser set classID=null,entranceMark=null,practiceSession=null where userID in( select userID from tblUser where classID in ( select classID from tblClass where entranceID in ( select entranceID from tblEntrance where courseID =@id))) delete from tblClass where classID in ( select classID from tblClass where entranceID in ( select entranceID from tblEntrance where courseID =@id)) delete from tblEntrance where entranceID in (select entranceID from tblEntrance where courseID = @id) delete from tblTopic where topicID in (select topicID from tblTopic where courseID =@id) delete from tblCourse where courseID =@id end
GO
/****** Object:  StoredProcedure [dbo].[delFAQ]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delFAQ]
@delFAQ int 
AS 
BEGIN 
DELETE FROM tblFAQ WHERE faqID =@delFAQ;
END


GO
/****** Object:  StoredProcedure [dbo].[delPayment]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[delPayment]
@delPayment varchar(50) 
AS 
BEGIN 
DELETE FROM tblPayment WHERE payID =@delPayment ;
END

GO
/****** Object:  StoredProcedure [dbo].[delTopic]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delTopic] 
@delTopic varchar(50) 
AS 
BEGIN 
DELETE FROM tblTopic WHERE topicID =@delTopic;
END


GO
/****** Object:  StoredProcedure [dbo].[delUser]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delUser]
@delUser varchar(50) 
AS 
BEGIN 
DELETE FROM tblUser WHERE userID=@delUser ;
END


GO
/****** Object:  StoredProcedure [dbo].[getAdminClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[getAdminClass]
as
begin
select * from tblClass
end
GO
/****** Object:  StoredProcedure [dbo].[getAdminCourse]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[getAdminCourse]

as
begin
select courseID,courseName,courseFee from tblCourse ;
end

GO
/****** Object:  StoredProcedure [dbo].[getAdminEntrances]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[getAdminEntrances]

as
begin
select * from tblEntrance ;
end
GO
/****** Object:  StoredProcedure [dbo].[getAdminFeedback]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getAdminFeedback]

as
begin
select faqID,faqQuestion,faqAnswer from tblFAQ 
order by faqID desc
end

GO
/****** Object:  StoredProcedure [dbo].[getAdminPayment]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getAdminPayment]

as
begin
select * from tblPayment 
order by payID desc
end

GO
/****** Object:  StoredProcedure [dbo].[getAdminResult]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[getAdminResult]

as
begin
select userID,userFullName,userDOB,userSex,entranceMark,practiceSession from tblUser ;
end

GO
/****** Object:  StoredProcedure [dbo].[getAdminTopic]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getAdminTopic]
as
begin
select * from tblTopic
end

GO
/****** Object:  StoredProcedure [dbo].[getAdminUser]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getAdminUser]

as
begin
select userID,userFullName,userDOB,userEmail,userSex from tblUser ;
end

GO
/****** Object:  StoredProcedure [dbo].[getansweredFB]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getansweredFB]
as
begin
select top 5 * from tblFAQ where (len(faqAnswer) > 0)
end
GO
/****** Object:  StoredProcedure [dbo].[getCourse]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getCourse]
as
begin
select * from tblCourse;
end
GO
/****** Object:  StoredProcedure [dbo].[getCourseID]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getCourseID]
as
begin
select courseID,courseName from tblCourse
end

GO
/****** Object:  StoredProcedure [dbo].[getEntrance]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getEntrance]
as
begin
select * from tblEntrance;
end
GO
/****** Object:  StoredProcedure [dbo].[getEntranceDetails]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getEntranceDetails]
@id varchar(50)
as
begin
select tblEntrance.entranceID as[Entrance Id : ],
tblCourse.courseName as[Course Name : ],
tblEntrance.entranceTitle as[Entrance Title : ],
tblEntrance.entranceFee as[Entrance Fee : ],
tblEntrance.entranceDate as[Entrance Date : ],
tblEntrance.startDate as[Start Reg Date : ],
tblEntrance.endDate as[End Reg Date : ] from tblEntrance join tblCourse on tblEntrance.courseID = tblCourse.courseID where entranceID = @id
end
GO
/****** Object:  StoredProcedure [dbo].[getEntranceID]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getEntranceID]
as
begin
select entranceID from tblEntrance
end

GO
/****** Object:  StoredProcedure [dbo].[getEntranceUserRegExam]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getEntranceUserRegExam]
@course varchar(50)
as
begin
select * from tblEntrance where tblEntrance.courseID =@course
end
GO
/****** Object:  StoredProcedure [dbo].[getPaymentAmount]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getPaymentAmount]
@paymentID int
as
begin
select tblPayment.payAmount from tblPayment where payID =@paymentID
end
GO
/****** Object:  StoredProcedure [dbo].[getRSConfirm]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getRSConfirm]
@userid varchar(50),
@classid varchar(50)
as
begin
select count(*) from tblPayment join tblClass on tblPayment.classID = tblClass.classID join tblUser on tblUser.classID = tblClass.classID where tblUser.userID =@userid and tbluser.classID =@classid
end
GO
/****** Object:  StoredProcedure [dbo].[getselectedEntrance]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getselectedEntrance]
@course varchar(50)
as
begin
select * from tblEntrance where tblEntrance.courseID =@course and DATEDIFF(day,endDate,GETDATE()) <=0
end
GO
/****** Object:  StoredProcedure [dbo].[getUserClass]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getUserClass]
@userid varchar(50)
as
begin
if (select tblUser.entranceMark from tblUser where tblUser.userID=@userid) >= 50
select tblClass.classID as [Class ID : ], 
tblClass.entranceID as [Entrance ID : ],
tblEntrance.entranceTitle as [Entrance Title : ], 
tblClass.startDate as [Start Date : ]
from tblPayment left join tblUser on tblPayment.userID = tblUser.userID
right join tblClass on tblPayment.classID = tblClass.classID 
right join tblEntrance on tblClass.entranceID = tblEntrance.entranceID
right join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblUser.userID=@userid and tblPayment.payAmount =tblCourse.courseFee and tblPayment.[is Paid] = 'Paid'
else
select tblClass.classID as [Class ID : ], 
tblClass.entranceID as [Entrance ID : ],
tblEntrance.entranceTitle as [Entrance Title : ], 
tblClass.startDate as [Start Date : ]
from tblPayment left join tblUser on tblPayment.userID = tblUser.userID
right join tblClass on tblPayment.classID = tblClass.classID 
right join tblEntrance on tblClass.entranceID = tblEntrance.entranceID
right join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblUser.userID=@userid and (tblPayment.payAmount =tblCourse.courseFee+1725) and tblPayment.[is Paid] = 'Paid'
end
GO
/****** Object:  StoredProcedure [dbo].[getUserPayment]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getUserPayment]
@userid varchar(50)
as
begin
select  tblPayment.payID as [Payment ID : ],
(select 'Entrance Fee' ) as [Entrance ID : ],
(select 'Not Divided Yet' ) as [Class ID : ], 
(select '' ) as [Start Date : ],
tblPayment.payAmount as [Amount : ],
tblPayment.[is Paid] as [Is Paid]
from tblPayment 
where tblPayment.userID =@userid and tblPayment.classID is null
union 
select tblPayment.payID as [Payment ID : ], 
tblClass.entranceID as [Entrance ID : ],
tblClass.classID as [Class ID : ], 
tblClass.startDate as [Start Date : ],
tblPayment.payAmount as [Amount : ],
tblPayment.[is Paid] as [Is Paid]
from tblUser join tblClass on tblUser.classID =tblClass.classID join tblPayment on tblPayment.classID =tblClass.classID
where tblPayment.userID = @userid and tblUser.userID=@userid
order by tblPayment.payID desc
end
GO
/****** Object:  StoredProcedure [dbo].[getUserResult]    Script Date: 11/20/2013 6:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getUserResult]
@userid varchar(50)
as
begin
select tblUser.userID as [User ID : ], tblUser.userFullName as [Full Name : ], tblUser.userDOB as [Date Of Birth : ],tblUser.classID as [Class ID : ], tblUser.entranceMark as [Entrance Mark : ] from tblUser where tblUser.userID = @userid
end
GO
/****** Object:  StoredProcedure [dbo].[regExam]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[regExam]
@userid varchar(50),
@amount float,
@entrance varchar(50)
as
begin
insert tblPayment(userID,payAmount,[is Paid]) values(@userid,@amount,'Not Paid')
update tblUser set classID = (select ClassID from tblClass where entranceID =@entrance) where userID = @userid
end
GO
/****** Object:  StoredProcedure [dbo].[regPrac]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[regPrac]
@id varchar(50)
as
begin
insert into tblPayment(classID,userID,payAmount,[is Paid]) values ((select tblUser.classID from tblUser where userID= @id),@id,1500,'Not Paid')
end
GO
/****** Object:  StoredProcedure [dbo].[regUser]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[regUser]
@id varchar(50),
@pass varchar(50),
@name varchar(50),
@dob date,
@mail varchar(50),
@sex varchar(50)
as
begin
insert into tblUser(userID,userPass,userFullName,userDOB,userEmail,userSex) values (@id,@pass,@name,@dob,@mail,@sex)
end
GO
/****** Object:  StoredProcedure [dbo].[searchAdminClass]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[searchAdminClass]
@course varchar(50)
as
begin
select tblClass.classID,tblClass.entranceID,tblClass.startDate,tblCourse.courseName from tblClass join tblEntrance on tblClass.entranceID = tblEntrance.entranceID join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblCourse.courseName like '%'+@course+'%'
end
GO
/****** Object:  StoredProcedure [dbo].[searchAdminCourse]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchAdminCourse]
@course varchar(50)
as
begin
select courseID,courseName,courseFee from tblCourse  where courseName like '%'+@course+'%';
end

GO
/****** Object:  StoredProcedure [dbo].[searchAdminEntrances]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchAdminEntrances]
@course varchar(50)
as
begin
select tblEntrance.entranceID,tblEntrance.courseID,tblEntrance.entranceTitle,tblEntrance.entranceFee,tblEntrance.entranceDate,tblEntrance.startDate,tblEntrance.endDate from tblEntrance join tblCourse on tblEntrance.courseID = tblCourse.courseID 
where tblCourse.courseName like '%'+@course+'%'
end
GO
/****** Object:  StoredProcedure [dbo].[searchAdminFeedback]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[searchAdminFeedback]
@id int
as
begin
select faqID,faqQuestion,faqAnswer from tblFAQ where faqID = @id or faqID = @id+1 or faqID =@id -1
order by faqID desc
end

GO
/****** Object:  StoredProcedure [dbo].[searchAdminPayment]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[searchAdminPayment]
@name varchar(50)
as
begin
select tblPayment.payID,tblPayment.AccID,tblpayment.userID,tblPayment.classID,tblPayment.payAmount,tblPayment.payDate,tblPayment.payType,tblPayment.[is Paid] from tblPayment join tblUser on tblPayment.userID = tblUser.userID where tblUser.userFullName like + '%'+@name+'%'
order by payID desc
end

GO
/****** Object:  StoredProcedure [dbo].[searchAdminRS]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchAdminRS]
@name varchar(50)
as
begin
select userID,userFullName,userDOB,userSex,entranceMark,practiceSession from tblUser where tblUser.userFullName like '%'+@name+'%' ;
end

GO
/****** Object:  StoredProcedure [dbo].[searchAdminTopic]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchAdminTopic]
@course varchar(50)
as
begin
select * from tblTopic join tblCourse on tblTopic.courseID = tblCourse.courseID where courseName like '%'+@course+'%'
end

GO
/****** Object:  StoredProcedure [dbo].[searchAdminUser]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchAdminUser]
@name varchar(50)
as
begin
select userID,userFullName,userDOB,userEmail,userSex from tblUser where tblUser.userFullName like  '%'+@name+'%'
end

GO
/****** Object:  StoredProcedure [dbo].[searchCourse]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[searchCourse]
@key varchar(50)
as
begin
select * from tblCourse where courseName like '%'+@key+'%'
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminClass]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[UpdateAdminClass]
@startDate date,
@ClassID varchar(50)
as
begin
update tblClass set startDate=@startDate where classID=@ClassID
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminCourse]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[UpdateAdminCourse]
  @courseID varchar(50),
  @courseName varchar(50),
  @courseFee float
as
begin
update tblCourse set courseName=@courseName, courseFee=@courseFee where courseID=@courseID ;
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminEntrances]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateAdminEntrances]
  @courseID varchar(50),
  @entranceID varchar(50),
  @entranceTitle varchar(50),
  @entranceFee float,
  @entranceDate datetime,
  @startDate datetime,
  @endDate datetime
as
begin
update tblEntrance set courseID=@courseID,entranceTitle=@entranceTitle, entranceFee=@entranceFee,entranceDate=@entranceDate,startDate=@startDate,endDate=@endDate where entranceID=@entranceID ;
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminFeedback]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateAdminFeedback]
  @faqID varchar(50),
  @faqQuestion varchar(100)
as
begin
update tblFAQ set faqAnswer=@faqQuestion where faqID=@faqID ;
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminPayment]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateAdminPayment]
  @payID varchar(50),
  @payAcc varchar(50),
  @payDate date,
  @isPaid varchar(50)
as
begin
update tblPayment set AccID=@payAcc,payDate=@payDate,[is Paid]=@isPaid,payType='Transfer' where payID=@payID ;
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminResult]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateAdminResult]
  @userID varchar(50),
  @entranceMark int
as
begin
update tbluser set entranceMark=@entranceMark where userID=@userID ;
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminTopic]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[UpdateAdminTopic]
@topicID varchar(50),
@courseID varchar(50),
@topicDes varchar(50),
@topicName varchar(50)
as
begin
update tblTopic set topicName=@topicName,courseID=@courseID,topicDes=@topicDes where topicID=@topicID
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateAdminUser]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateAdminUser]
  @userID varchar(50),
  @FullName varchar(50),
  @userDOB varchar(50),
  @userEmail varchar(50),
  @userSex varchar(50)
as
begin
update tblUser set userFullName=@FullName,userDOB=@userDOB,userEmail=@userEmail,userSex=@userSex where userID=@userID ;
end
GO
/****** Object:  StoredProcedure [dbo].[updateUserEntrance]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[updateUserEntrance]
@userid varchar(50),
@accid varchar(50),
@date date,
@type varchar(50)
as
begin
update tblPayment set [is Paid] ='Paid',AccID=@accid,payDate=@date,payType=@type where tblPayment.payID = (select payID from tblPayment left join tblUser on tblPayment.userID = tblUser.userID
right join tblClass on tblPayment.classID = tblClass.classID 
right join tblEntrance on tblClass.entranceID = tblEntrance.entranceID
right join tblCourse on tblEntrance.courseID = tblCourse.courseID
where tblUser.userID=@userid and tblPayment.payAmount =tblEntrance.entranceFee)
end
GO
/****** Object:  StoredProcedure [dbo].[userConfirmClass]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[userConfirmClass]
@userID varchar(50),
@ClassID varchar(50),
@mark int,
@prac int
as
begin
if(@mark >=50)
begin
insert into tblPayment(userID,classID,payAmount,[is Paid]) 
values (@userID,@ClassID,
(select tblCourse.courseFee 
from tblClass join tblEntrance on tblClass.entranceID=tblEntrance.entranceID 
join tblCourse on tblEntrance.courseID = tblCourse.courseID where tblClass.classID=@ClassID),
'Not Paid')
if(@prac =1)
begin
insert into tblPayment(userID,classID,payAmount,[is Paid]) 
values (@userID,@ClassID,1000,'Not Paid')
end
end
else
begin
insert into tblPayment(userID,classID,payAmount,[is Paid]) 
values (@userID,@ClassID,
(select tblCourse.courseFee 
from tblClass join tblEntrance on tblClass.entranceID=tblEntrance.entranceID 
join tblCourse on tblEntrance.courseID = tblCourse.courseID where tblClass.classID=@ClassID)+1725,
'Not Paid')
if(@prac =1)
begin
insert into tblPayment(userID,classID,payAmount,[is Paid]) 
values (@userID,@ClassID,1000,'Not Paid')
end
end
end
GO
/****** Object:  Table [dbo].[tblAdmin]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAdmin](
	[adminID] [varchar](50) NOT NULL,
	[adminPass] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblAdmin] PRIMARY KEY CLUSTERED 
(
	[adminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBank]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBank](
	[AccountID] [int] IDENTITY(79000,1) NOT NULL,
	[PinCode] [int] NOT NULL,
	[Balance] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCenter]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCenter](
	[centerID] [varchar](50) NOT NULL,
	[centerName] [varchar](50) NULL,
	[centerDes] [varchar](max) NULL,
 CONSTRAINT [PK_tblCenter] PRIMARY KEY CLUSTERED 
(
	[centerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblClass]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblClass](
	[classID] [varchar](50) NOT NULL,
	[entranceID] [varchar](50) NULL,
	[startDate] [date] NULL,
 CONSTRAINT [PK_tblClass] PRIMARY KEY CLUSTERED 
(
	[classID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourse]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCourse](
	[courseID] [varchar](50) NOT NULL,
	[courseName] [varchar](50) NULL,
	[courseFee] [money] NULL,
 CONSTRAINT [PK_tblCourse] PRIMARY KEY CLUSTERED 
(
	[courseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblEntrance]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEntrance](
	[entranceID] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[entranceTitle] [varchar](50) NULL,
	[entranceFee] [money] NULL,
	[entranceDate] [date] NULL,
	[startDate] [date] NULL,
	[endDate] [date] NULL,
 CONSTRAINT [PK_tblEntrance] PRIMARY KEY CLUSTERED 
(
	[entranceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFAQ]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFAQ](
	[faqID] [int] IDENTITY(1,1) NOT NULL,
	[faqEmail] [varchar](50) NOT NULL,
	[faqQuestion] [varchar](max) NOT NULL,
	[faqAnswer] [varchar](max) NULL,
 CONSTRAINT [PK_tblFAQ] PRIMARY KEY CLUSTERED 
(
	[faqID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPayment](
	[payID] [int] IDENTITY(1,1) NOT NULL,
	[AccID] [varchar](50) NULL,
	[userID] [varchar](50) NOT NULL,
	[classID] [varchar](50) NULL,
	[payAmount] [money] NOT NULL,
	[payDate] [date] NULL,
	[payType] [varchar](50) NULL,
	[is Paid] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblPayment] PRIMARY KEY CLUSTERED 
(
	[payID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTopic]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTopic](
	[topicID] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[topicName] [varchar](50) NULL,
	[topicDes] [varchar](max) NULL,
 CONSTRAINT [PK_tblTopic] PRIMARY KEY CLUSTERED 
(
	[topicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 11/20/2013 6:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [varchar](50) NOT NULL,
	[userPass] [varchar](50) NOT NULL,
	[userFullName] [varchar](50) NULL,
	[userDOB] [varchar](50) NOT NULL,
	[userEmail] [varchar](50) NOT NULL,
	[userSex] [varchar](50) NULL,
	[classID] [varchar](50) NULL,
	[entranceMark] [int] NULL,
	[practiceSession] [int] NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tblClass]  WITH CHECK ADD  CONSTRAINT [FK_tblClass_tblEntrance] FOREIGN KEY([entranceID])
REFERENCES [dbo].[tblEntrance] ([entranceID])
GO
ALTER TABLE [dbo].[tblClass] CHECK CONSTRAINT [FK_tblClass_tblEntrance]
GO
ALTER TABLE [dbo].[tblEntrance]  WITH CHECK ADD  CONSTRAINT [FK_tblEntrance_tblCourse] FOREIGN KEY([courseID])
REFERENCES [dbo].[tblCourse] ([courseID])
GO
ALTER TABLE [dbo].[tblEntrance] CHECK CONSTRAINT [FK_tblEntrance_tblCourse]
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD  CONSTRAINT [FK_tblPayment_tblClass] FOREIGN KEY([classID])
REFERENCES [dbo].[tblClass] ([classID])
GO
ALTER TABLE [dbo].[tblPayment] CHECK CONSTRAINT [FK_tblPayment_tblClass]
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD  CONSTRAINT [FK_tblPayment_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblPayment] CHECK CONSTRAINT [FK_tblPayment_tblUser]
GO
ALTER TABLE [dbo].[tblTopic]  WITH CHECK ADD  CONSTRAINT [FK_tblTopic_tblCourse] FOREIGN KEY([courseID])
REFERENCES [dbo].[tblCourse] ([courseID])
GO
ALTER TABLE [dbo].[tblTopic] CHECK CONSTRAINT [FK_tblTopic_tblCourse]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblClass] FOREIGN KEY([classID])
REFERENCES [dbo].[tblClass] ([classID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblClass]
GO
USE [SymphonyLtd]
GO
INSERT [dbo].[tblCourse] ([courseID], [courseName], [courseFee]) VALUES (N'AJP2', N'Avanced Java 2 ', 345.0000)
GO
INSERT [dbo].[tblCourse] ([courseID], [courseName], [courseFee]) VALUES (N'DDSQL', N'SQL Server ', 563.0000)
GO
INSERT [dbo].[tblCourse] ([courseID], [courseName], [courseFee]) VALUES (N'JP1', N'Java1', 500.0000)
GO
INSERT [dbo].[tblCourse] ([courseID], [courseName], [courseFee]) VALUES (N'JP2', N'Java2 ', 450.0000)
GO
INSERT [dbo].[tblEntrance] ([entranceID], [courseID], [entranceTitle], [entranceFee], [entranceDate], [startDate], [endDate]) VALUES (N'E01', N'AJP2', N'Entrance AJP2', 500.0000, CAST(0xD6370B00 AS Date), CAST(0xDD370B00 AS Date), CAST(0x35380B00 AS Date))
GO
INSERT [dbo].[tblEntrance] ([entranceID], [courseID], [entranceTitle], [entranceFee], [entranceDate], [startDate], [endDate]) VALUES (N'E02', N'AJP2', N'Entrance AJP2', 23.0000, CAST(0xD1370B00 AS Date), CAST(0xD8370B00 AS Date), CAST(0x30380B00 AS Date))
GO
INSERT [dbo].[tblEntrance] ([entranceID], [courseID], [entranceTitle], [entranceFee], [entranceDate], [startDate], [endDate]) VALUES (N'E03', N'DDSQL', N'Entrance SQL', 100.0000, CAST(0xCE370B00 AS Date), CAST(0xD1370B00 AS Date), CAST(0x05380B00 AS Date))
GO
INSERT [dbo].[tblEntrance] ([entranceID], [courseID], [entranceTitle], [entranceFee], [entranceDate], [startDate], [endDate]) VALUES (N'E04', N'JP1', N'Entrance Java1', 50.0000, CAST(0xD1370B00 AS Date), CAST(0xD8370B00 AS Date), CAST(0x30380B00 AS Date))
GO
INSERT [dbo].[tblClass] ([classID], [entranceID], [startDate]) VALUES (N'C01', N'E01', CAST(0xDD370B00 AS Date))
GO
INSERT [dbo].[tblClass] ([classID], [entranceID], [startDate]) VALUES (N'C02', N'E02', CAST(0xD8370B00 AS Date))
GO
INSERT [dbo].[tblClass] ([classID], [entranceID], [startDate]) VALUES (N'C03', N'E03', CAST(0xD1370B00 AS Date))
GO
INSERT [dbo].[tblClass] ([classID], [entranceID], [startDate]) VALUES (N'C04', N'E04', CAST(0xD8370B00 AS Date))
GO
INSERT [dbo].[tblUser] ([userID], [userPass], [userFullName], [userDOB], [userEmail], [userSex], [classID], [entranceMark], [practiceSession]) VALUES (N'NickyVM', N'123', N'Nicky Vo', N'11/13/2013', N'nv@gmail.com', N'Male', NULL, NULL, NULL)
GO
INSERT [dbo].[tblUser] ([userID], [userPass], [userFullName], [userDOB], [userEmail], [userSex], [classID], [entranceMark], [practiceSession]) VALUES (N'Steven', N'12345678', N'Steven Bear', N'11/6/2013', N'stev@gmail.com', N'Male', N'C02', 40, 1)
GO
INSERT [dbo].[tblUser] ([userID], [userPass], [userFullName], [userDOB], [userEmail], [userSex], [classID], [entranceMark], [practiceSession]) VALUES (N'TinaN', N'123', N'Tina Nguyen', N'1994-12-26', N'tn@gmail.com', N'female', N'C02', 81, 0)
GO
INSERT [dbo].[tblUser] ([userID], [userPass], [userFullName], [userDOB], [userEmail], [userSex], [classID], [entranceMark], [practiceSession]) VALUES (N'Vincent', N'123', N'Vincent Pham', N'1994-09-08', N'vp@gmail.com', N'male', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tblPayment] ON 

GO
INSERT [dbo].[tblPayment] ([payID], [AccID], [userID], [classID], [payAmount], [payDate], [payType], [is Paid]) VALUES (3, N'790002', N'TinaN', N'C02', 400.0000, CAST(0x46370B00 AS Date), N'Transfer', N'Paid')
GO
INSERT [dbo].[tblPayment] ([payID], [AccID], [userID], [classID], [payAmount], [payDate], [payType], [is Paid]) VALUES (39, N'79000', N'Steven', N'C02', 1500.0000, CAST(0xD6370B00 AS Date), N'Transfer', N'Not Paid')
GO
SET IDENTITY_INSERT [dbo].[tblPayment] OFF
GO
INSERT [dbo].[tblTopic] ([topicID], [courseID], [topicName], [topicDes]) VALUES (N'AJP2 part1', N'AJP2', N'ArrayList and Generic', NULL)
GO
INSERT [dbo].[tblTopic] ([topicID], [courseID], [topicName], [topicDes]) VALUES (N'SQ', N'DDSQL', N'SQL Server', N'SQL')
GO
INSERT [dbo].[tblAdmin] ([adminID], [adminPass]) VALUES (N'admin', N'12345678')
GO
SET IDENTITY_INSERT [dbo].[tblBank] ON 

GO
INSERT [dbo].[tblBank] ([AccountID], [PinCode], [Balance]) VALUES (79000, 111, 406970.0000)
GO
INSERT [dbo].[tblBank] ([AccountID], [PinCode], [Balance]) VALUES (79001, 222, 5000.0000)
GO
INSERT [dbo].[tblBank] ([AccountID], [PinCode], [Balance]) VALUES (79002, 333, 8000.0000)
GO
SET IDENTITY_INSERT [dbo].[tblBank] OFF
GO
INSERT [dbo].[tblCenter] ([centerID], [centerName], [centerDes]) VALUES (N'FAT', N'Head FAT', N'Head Quarter')
GO
INSERT [dbo].[tblCenter] ([centerID], [centerName], [centerDes]) VALUES (N'FAT 1', N'Dist3 FAT', N'FAT Center in Dist 3rd')
GO
SET IDENTITY_INSERT [dbo].[tblFAQ] ON 

GO
INSERT [dbo].[tblFAQ] ([faqID], [faqEmail], [faqQuestion], [faqAnswer]) VALUES (1, N'NV@GMAIL.COM', N'What is SymphonyLTD?', NULL)
GO
INSERT [dbo].[tblFAQ] ([faqID], [faqEmail], [faqQuestion], [faqAnswer]) VALUES (2, N'nhat12@yahoo.com', N'How can i register ?', N'You only need click  "Register" on Login form   ')
GO
INSERT [dbo].[tblFAQ] ([faqID], [faqEmail], [faqQuestion], [faqAnswer]) VALUES (3, N'Stevent@gmail.com', N'How can i pay my entrance exam?', N'First, you need login your account. Second you click on RegisterExam tab, click the Register button and click My payment tab to pay the exam you registered ')
GO
SET IDENTITY_INSERT [dbo].[tblFAQ] OFF
GO

GO
USE [master]
GO
ALTER DATABASE [SymphonyLtd2] SET  READ_WRITE 
GO
