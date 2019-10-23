USE [moply]
GO
/****** Object:  FullTextCatalog [Test_1]    Script Date: 7/26/2019 9:18:49 AM ******/
CREATE FULLTEXT CATALOG [Test_1] 
GO
/****** Object:  UserDefinedFunction [dbo].[non_unicode_convert]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[non_unicode_convert](@inputVar NVARCHAR(MAX) )
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END
GO
/****** Object:  Table [dbo].[account]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[username] [varchar](31) NOT NULL,
	[password] [varchar](31) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[artist]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[artist](
	[artistid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[gender] [bit] NULL,
	[dob] [datetime] NULL,
	[nationality] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[artistid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[artistresource]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[artistresource](
	[artistid] [int] NULL,
	[imgPath] [nvarchar](100) NULL,
	[inforPath] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[countryid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[countryid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feature]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feature](
	[servletpath] [nvarchar](31) NOT NULL,
	[featurename] [nvarchar](31) NULL,
PRIMARY KEY CLUSTERED 
(
	[servletpath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kind]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kind](
	[kindid] [int] NOT NULL,
	[kindname] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[kindid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[language]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[language](
	[langid] [int] NOT NULL,
	[langname] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[langid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[playlist]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[playlist](
	[playlistid] [int] NOT NULL,
	[playlistname] [nvarchar](31) NULL,
	[username] [varchar](31) NULL,
PRIMARY KEY CLUSTERED 
(
	[playlistid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[playlist_song]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[playlist_song](
	[playlistid] [int] NOT NULL,
	[songid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[playlistid] ASC,
	[songid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[roleid] [int] NOT NULL,
	[rolename] [nvarchar](31) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_account]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_account](
	[username] [varchar](31) NOT NULL,
	[roleid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_feature]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_feature](
	[roleid] [int] NOT NULL,
	[servletpath] [nvarchar](31) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleid] ASC,
	[servletpath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[song]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[song](
	[songid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[artistid] [int] NULL,
	[langid] [int] NULL,
	[composer] [nvarchar](50) NULL,
	[countryid] [int] NULL,
	[kindid] [int] NULL,
	[uploader] [varchar](31) NULL,
PRIMARY KEY CLUSTERED 
(
	[songid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[songresource]    Script Date: 7/26/2019 9:18:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[songresource](
	[songid] [int] NULL,
	[trackPath] [nvarchar](100) NULL,
	[inforPath] [nvarchar](100) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[account] ([username], [password]) VALUES (N'admin', N'admin')
INSERT [dbo].[account] ([username], [password]) VALUES (N'user1', N'user1')
INSERT [dbo].[account] ([username], [password]) VALUES (N'user2', N'user2')
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (0, N'unnamed', NULL, NULL, NULL)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (1, N'Son Tung M-TP', 1, CAST(N'1994-07-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (2, N'Justin Bieber', 1, CAST(N'1994-01-03T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (3, N'Chen', 1, CAST(N'1994-07-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (4, N'Yoon Mi Rae', 0, CAST(N'1990-01-05T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (5, N'Erik', 1, CAST(N'1996-01-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (6, N'Taylor Swift', 0, CAST(N'1990-12-12T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (7, N'Jay Chou', 1, CAST(N'1984-12-05T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (8, N'Westlife', 1, CAST(N'1998-01-01T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (9, N'Adele', 0, CAST(N'1988-05-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (10, N'Alan Walker', 1, CAST(N'1998-01-01T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (11, N'Anh Tu Phan', 1, CAST(N'1999-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (12, N'Tran Duc Chien', 0, CAST(N'1999-12-22T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (13, N'BLACKPINK', 0, CAST(N'2016-08-08T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (14, N'BIGBANG', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (15, N'Justatee', 1, CAST(N'1991-01-11T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (16, N'Hồng Chà', 0, CAST(N'1999-04-22T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (17, N'MKJ', 0, CAST(N'1992-01-01T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (18, N'Martin Tunge', 1, CAST(N'1990-02-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (19, N'Mr. Probz ', 1, CAST(N'1984-05-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (20, N'Hardwell', 1, CAST(N'1987-05-09T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artist] ([artistid], [name], [gender], [dob], [nationality]) VALUES (21, N'The Chainsmokers', 1, CAST(N'1998-06-08T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (1, N'resources/img/artistimg/1.jpg', N'resources/info/artistinfo/1.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (3, N'resources/img/artistimg/3.jpg', N'resources/info/artistinfo/3.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (4, N'resources/img/artistimg/4.jpg', N'resources/info/artistinfo/4.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (5, N'resources/img/artistimg/5.jpg', N'resources/info/artistinfo/5.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (6, N'resources/img/artistimg/6.jpg', N'resources/info/artistinfo/6.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (7, N'resources/img/artistimg/7.jpg', N'resources/info/artistinfo/7.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (8, N'resources/img/artistimg/8.jpg', N'resources/info/artistinfo/8.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (0, N'resources/img/artistimg/0.jpg', N'resources/info/artistinfo/0.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (2, N'resources/img/artistimg/2.jpg', N'resources/info/artistinfo/2.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (9, N'resources/img/artistimg/9.jpg', N'resources/info/artistinfo/9.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (10, N'resources/img/artistimg/10.jpg', N'resources/info/artistinfo/10.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (11, N'resources/img/artistimg/11.jpg', N'resources/info/artistinfo/11.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (13, N'resources/img/artistimg/13.jpg', N'resources/info/artistinfo/13.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (14, N'resources/img/artistimg/14.jpg', N'resources/info/artistinfo/14.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (15, N'resources/img/artistimg/15.jpg', N'resources/info/artistinfo/15.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (16, N'resources/img/artistimg/16.jpg', N'resources/info/artistinfo/16.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (17, N'resources/img/artistimg/17.jpg', N'resources/info/artistinfo/17.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (18, N'resources/img/artistimg/18.jpg', N'resources/info/artistinfo/18.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (19, N'resources/img/artistimg/19.jpg', N'resources/info/artistinfo/19.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (20, N'resources/img/artistimg/20.jpg', N'resources/info/artistinfo/20.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (12, N'resources/img/artistimg/12.jpg', N'resources/info/artistinfo/12.txt')
INSERT [dbo].[artistresource] ([artistid], [imgPath], [inforPath]) VALUES (21, N'resources/img/artistimg/21.jpg', N'resources/info/artistinfo/21.txt')
INSERT [dbo].[country] ([countryid], [name]) VALUES (0, N'Other')
INSERT [dbo].[country] ([countryid], [name]) VALUES (1, N'Vietnam')
INSERT [dbo].[country] ([countryid], [name]) VALUES (2, N'America')
INSERT [dbo].[country] ([countryid], [name]) VALUES (3, N'China')
INSERT [dbo].[country] ([countryid], [name]) VALUES (4, N'Japan')
INSERT [dbo].[country] ([countryid], [name]) VALUES (5, N'Korea')
INSERT [dbo].[country] ([countryid], [name]) VALUES (6, N'Ireland')
INSERT [dbo].[country] ([countryid], [name]) VALUES (7, N'Canada')
INSERT [dbo].[feature] ([servletpath], [featurename]) VALUES (N'/adminpanel', N'adminpanel')
INSERT [dbo].[feature] ([servletpath], [featurename]) VALUES (N'/createartist', N'createartist')
INSERT [dbo].[feature] ([servletpath], [featurename]) VALUES (N'/deletesong', N'deletesong')
INSERT [dbo].[feature] ([servletpath], [featurename]) VALUES (N'/editsong', N'editsong')
INSERT [dbo].[feature] ([servletpath], [featurename]) VALUES (N'/listsongs', N'listsong')
INSERT [dbo].[kind] ([kindid], [kindname]) VALUES (0, N'Other')
INSERT [dbo].[kind] ([kindid], [kindname]) VALUES (1, N'Dance')
INSERT [dbo].[kind] ([kindid], [kindname]) VALUES (2, N'Hiphop')
INSERT [dbo].[kind] ([kindid], [kindname]) VALUES (3, N'EDM')
INSERT [dbo].[kind] ([kindid], [kindname]) VALUES (4, N'Pop-Ballad')
INSERT [dbo].[kind] ([kindid], [kindname]) VALUES (5, N'R&B')
INSERT [dbo].[language] ([langid], [langname]) VALUES (0, N'Other')
INSERT [dbo].[language] ([langid], [langname]) VALUES (1, N'Vietnamese')
INSERT [dbo].[language] ([langid], [langname]) VALUES (2, N'English')
INSERT [dbo].[language] ([langid], [langname]) VALUES (3, N'Chinese')
INSERT [dbo].[language] ([langid], [langname]) VALUES (4, N'Japanese')
INSERT [dbo].[language] ([langid], [langname]) VALUES (5, N'Korean')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (1, N'ATP', N'admin')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (2, N'Test 3', N'user1')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (3, N'dfgdf', N'admin')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (4, N'test doi ten', N'admin')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (5, N'doiten', N'user2')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (6, N'Anh Tu Phan', N'admin')
INSERT [dbo].[playlist] ([playlistid], [playlistname], [username]) VALUES (7, N'Quoc Tuan', N'user1')
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 3)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 4)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 5)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 6)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 8)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 9)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 22)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 23)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 43)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (1, 44)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (2, 2)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (2, 3)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (2, 5)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (3, 21)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (3, 44)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (4, 6)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (4, 22)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (4, 35)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (5, 4)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (6, 2)
INSERT [dbo].[playlist_song] ([playlistid], [songid]) VALUES (7, 3)
INSERT [dbo].[role] ([roleid], [rolename]) VALUES (1, N'admin')
INSERT [dbo].[role] ([roleid], [rolename]) VALUES (2, N'mod')
INSERT [dbo].[role] ([roleid], [rolename]) VALUES (3, N'member')
INSERT [dbo].[role_account] ([username], [roleid]) VALUES (N'admin', 1)
INSERT [dbo].[role_account] ([username], [roleid]) VALUES (N'user1', 2)
INSERT [dbo].[role_account] ([username], [roleid]) VALUES (N'user2', 3)
INSERT [dbo].[role_feature] ([roleid], [servletpath]) VALUES (1, N'/adminpanel')
INSERT [dbo].[role_feature] ([roleid], [servletpath]) VALUES (1, N'/createartist')
INSERT [dbo].[role_feature] ([roleid], [servletpath]) VALUES (1, N'/deletesong')
INSERT [dbo].[role_feature] ([roleid], [servletpath]) VALUES (1, N'/editsong')
INSERT [dbo].[role_feature] ([roleid], [servletpath]) VALUES (1, N'/listsongs')
INSERT [dbo].[role_feature] ([roleid], [servletpath]) VALUES (2, N'/createartist')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (1, N'Hãy trao cho anh', 1, 1, N'Sơn Tùng M-TP', 1, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (2, N'Sứ Thanh Hoa', 7, 3, N'FANG,WEN-SHAN', 3, 0, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (3, N'Sau Tất Cả', 5, 1, N'Khắc Hưng', 1, 4, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (4, N'Mùa Đông', 5, 1, N'Hoàng Thống', 1, 4, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (5, N'I love you', 4, 5, N'Yoon Rae', 5, 5, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (6, N'Nắng Ấm xa dần', 1, 1, N'Sơn Tùng M-TP', 1, 5, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (7, N'More Than Words ', 8, 2, N'Gary F. Cherone', 6, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (8, N'My Love', 8, 2, N'Per Nylen ', 6, 4, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (9, N'You Raise Me Up', 8, 2, N'Brendan Graham ', 6, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (10, N'All Around The World', 2, 2, N' Nasri Atweh', 2, 4, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (11, N'Pray', 2, 2, N'ATWEH NASRI TONY', 2, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (12, N'Love Me', 2, 2, N'', 2, 4, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (13, N'Take You', 2, 2, N'Raphael Jurdin', 2, 4, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (14, N'Cold Water', 0, 0, N'Phillip Meckseper', 0, 0, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (15, N'What Do You Mean', 2, 2, N'Justin Drew Bieber', 2, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (16, N'Thought Of You', 2, 2, N'Thomas Wesley Pentz', 2, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (17, N'Hello', 9, 2, N'Adele Adkins / Gregory Kurstin', 2, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (18, N'Shoop', 0, 2, N'S.N.P', 2, 0, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (19, N'Kiss The Rain', 0, 4, N'Yiruma', 4, 0, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (20, N'Fade', 10, 2, N'Alan Walker', 2, 3, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (21, N'ME!', 6, 2, N' Brendon Urie', 2, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (22, N'Có Chàng Trai Viết Lên Cây', 11, 1, N'Phan Mạnh Quỳnh', 1, 0, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (23, N'Set Fire To The Rain', 9, 2, N'Adele Adkins / Fraser T Smith', 2, 4, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (24, N'Everytime (DOTS  OST)', 3, 5, N'', 5, 5, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (25, N'Say It! What Are You Doing?', 3, 5, N'', 5, 5, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (26, N'Die In Your Arms', 2, 2, N'Alphonso Mizell', 2, 5, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (27, N'Lorem Ipsum', 12, 5, N'Poind', 4, 2, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (28, N'Kill This Love', 13, 5, N'R.Tee / Hong Jun Park', 5, 2, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (29, N'Bop bop baby', 8, 2, N'Westlife', 2, 0, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (30, N'Haru Haru', 14, 5, N'GD', 5, 2, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (31, N'Hey Stephen', 6, 2, N'Taylor Swift', 2, 1, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (32, N'Loser', 14, 5, N'GD', 5, 0, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (33, N'Rolling in the deep', 9, 2, N'Adele', 2, 5, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (34, N'Touch Love', 4, 5, N'', 5, 5, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (35, N'On My Way', 10, 0, N'Alan Walker', 2, 1, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (36, N'Lily', 10, 0, N'Alan Walker', 2, 3, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (37, N'Time', 17, 0, N'MKJ', 2, 1, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (38, N'Wicked Wonderland', 18, 0, N'Martin Tungevaag', 2, 1, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (39, N'Seve', 17, 0, N'MKJ', 0, 1, N'admin')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (40, N'Take Me To Infinity', 17, 0, N'Brendan Graham ', 0, 3, N'user2')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (41, N'Friendships', 0, 0, N'unnamed', 0, 3, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (42, N' Numa Numa 2', 0, 0, N'unnamed', 0, 2, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (43, N'Fine Ass Mess', 19, 2, N'Mr. Probz ', 2, 2, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (44, N' Iggy Azalea', 0, 0, N'unnamed', 0, 2, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (45, N'Summer Air', 20, 2, N'unnamed', 0, 3, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (46, N'This Feeling', 21, 0, N'unnamed', 0, 3, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (47, N'Save', 0, 0, N'unnamed', 0, 3, N'user1')
INSERT [dbo].[song] ([songid], [name], [artistid], [langid], [composer], [countryid], [kindid], [uploader]) VALUES (48, N'Lost Control', 10, 0, N'Alan Walker', 2, 1, N'user1')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (1, N'resources/audios/songs/1.mp3', N'resources/info/songinfo/1.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (2, N'resources/audios/songs/2.mp3', N'resources/info/songinfo/2.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (3, N'resources/audios/songs/3.mp3', N'resources/info/songinfo/3.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (4, N'resources/audios/songs/4.mp3', N'resources/info/songinfo/4.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (6, N'resources/audios/songs/6.mp3', N'resources/info/songinfo/6.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (9, N'resources/audios/songs/9.mp3', N'resources/info/songinfo/9.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (10, N'resources/audios/songs/10.mp3', N'resources/info/songinfo/10.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (17, N'resources/audios/songs/17.mp3', N'resources/info/songinfo/17.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (19, N'resources/audios/songs/19.mp3', N'resources/info/songinfo/19.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (21, N'resources/audios/songs/21.mp3', N'resources/info/songinfo/21.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (23, N'resources/audios/songs/23.mp3', N'resources/info/songinfo/23.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (24, N'resources/audios/songs/24.mp3', N'resources/info/songinfo/24.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (25, N'resources/audios/songs/25.mp3', N'resources/info/songinfo/25.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (26, N'resources/audios/songs/26.mp3', N'resources/info/songinfo/26.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (27, N'resources/audios/songs/27.mp3', N'resources/info/songinfo/27.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (31, N'resources/audios/songs/31.mp3', N'resources/info/songinfo/31.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (32, N'resources/audios/songs/32.mp3', N'resources/info/songinfo/32.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (37, N'resources/audios/songs/37.mp3', N'resources/info/songinfo/37.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (38, N'resources/audios/songs/38.mp3', N'resources/info/songinfo/38.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (39, N'resources/audios/songs/39.mp3', N'resources/info/songinfo/39.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (42, N'resources/audios/songs/42.mp3', N'resources/info/songinfo/42.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (45, N'resources/audios/songs/45.mp3', N'resources/info/songinfo/45.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (48, N'resources/audios/songs/48.mp3', N'resources/info/songinfo/48.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (5, N'resources/audios/songs/5.mp3', N'resources/info/songinfo/5.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (11, N'resources/audios/songs/11.mp3', N'resources/info/songinfo/11.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (13, N'resources/audios/songs/13.mp3', N'resources/info/songinfo/13.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (14, N'resources/audios/songs/14.mp3', N'resources/info/songinfo/14.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (43, N'resources/audios/songs/43.mp3', N'resources/info/songinfo/43.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (7, N'resources/audios/songs/7.mp3', N'resources/info/songinfo/7.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (8, N'resources/audios/songs/8.mp3', N'resources/info/songinfo/8.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (12, N'resources/audios/songs/12.mp3', N'resources/info/songinfo/12.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (15, N'resources/audios/songs/15.mp3', N'resources/info/songinfo/15.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (16, N'resources/audios/songs/16.mp3', N'resources/info/songinfo/16.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (18, N'resources/audios/songs/18.mp3', N'resources/info/songinfo/18.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (33, N'resources/audios/songs/33.mp3', N'resources/info/songinfo/33.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (20, N'resources/audios/songs/20.mp3', N'resources/info/songinfo/20.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (22, N'resources/audios/songs/22.mp3', N'resources/info/songinfo/22.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (34, N'resources/audios/songs/34.mp3', N'resources/info/songinfo/34.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (28, N'resources/audios/songs/28.mp3', N'resources/info/songinfo/28.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (29, N'resources/audios/songs/29.mp3', N'resources/info/songinfo/29.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (30, N'resources/audios/songs/30.mp3', N'resources/info/songinfo/30.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (35, N'resources/audios/songs/35.mp3', N'resources/info/songinfo/35.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (36, N'resources/audios/songs/36.mp3', N'resources/info/songinfo/36.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (41, N'resources/audios/songs/41.mp3', N'resources/info/songinfo/41.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (44, N'resources/audios/songs/44.mp3', N'resources/info/songinfo/44.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (46, N'resources/audios/songs/46.mp3', N'resources/info/songinfo/46.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (47, N'resources/audios/songs/47.mp3', N'resources/info/songinfo/47.txt')
INSERT [dbo].[songresource] ([songid], [trackPath], [inforPath]) VALUES (40, N'resources/audios/songs/40.mp3', N'resources/info/songinfo/40.txt')
ALTER TABLE [dbo].[artist]  WITH CHECK ADD FOREIGN KEY([nationality])
REFERENCES [dbo].[country] ([countryid])
GO
ALTER TABLE [dbo].[artistresource]  WITH CHECK ADD FOREIGN KEY([artistid])
REFERENCES [dbo].[artist] ([artistid])
GO
ALTER TABLE [dbo].[playlist]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[playlist_song]  WITH CHECK ADD FOREIGN KEY([playlistid])
REFERENCES [dbo].[playlist] ([playlistid])
GO
ALTER TABLE [dbo].[playlist_song]  WITH CHECK ADD FOREIGN KEY([songid])
REFERENCES [dbo].[song] ([songid])
GO
ALTER TABLE [dbo].[role_account]  WITH CHECK ADD FOREIGN KEY([roleid])
REFERENCES [dbo].[role] ([roleid])
GO
ALTER TABLE [dbo].[role_account]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[role_feature]  WITH CHECK ADD FOREIGN KEY([roleid])
REFERENCES [dbo].[role] ([roleid])
GO
ALTER TABLE [dbo].[role_feature]  WITH CHECK ADD FOREIGN KEY([servletpath])
REFERENCES [dbo].[feature] ([servletpath])
GO
ALTER TABLE [dbo].[song]  WITH CHECK ADD FOREIGN KEY([artistid])
REFERENCES [dbo].[artist] ([artistid])
GO
ALTER TABLE [dbo].[song]  WITH CHECK ADD FOREIGN KEY([countryid])
REFERENCES [dbo].[country] ([countryid])
GO
ALTER TABLE [dbo].[song]  WITH CHECK ADD FOREIGN KEY([kindid])
REFERENCES [dbo].[kind] ([kindid])
GO
ALTER TABLE [dbo].[song]  WITH CHECK ADD FOREIGN KEY([langid])
REFERENCES [dbo].[language] ([langid])
GO
ALTER TABLE [dbo].[song]  WITH CHECK ADD  CONSTRAINT [uploader] FOREIGN KEY([uploader])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[song] CHECK CONSTRAINT [uploader]
GO
ALTER TABLE [dbo].[songresource]  WITH CHECK ADD FOREIGN KEY([songid])
REFERENCES [dbo].[song] ([songid])
GO
