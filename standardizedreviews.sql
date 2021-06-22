USE [master]
GO
/****** Object:  Database [StandardizedReviews]    Script Date: 5/4/2020 11:06:58 PM ******/
CREATE DATABASE [StandardizedReviews]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StandardizedReviews', FILENAME = N'/var/opt/mssql/data/StandardizedReviews.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StandardizedReviews_log', FILENAME = N'/var/opt/mssql/data/StandardizedReviews_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [StandardizedReviews] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StandardizedReviews].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StandardizedReviews] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StandardizedReviews] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StandardizedReviews] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StandardizedReviews] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StandardizedReviews] SET ARITHABORT OFF 
GO
ALTER DATABASE [StandardizedReviews] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StandardizedReviews] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StandardizedReviews] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StandardizedReviews] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StandardizedReviews] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StandardizedReviews] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StandardizedReviews] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StandardizedReviews] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StandardizedReviews] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StandardizedReviews] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StandardizedReviews] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StandardizedReviews] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StandardizedReviews] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StandardizedReviews] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StandardizedReviews] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StandardizedReviews] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StandardizedReviews] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StandardizedReviews] SET RECOVERY FULL 
GO
ALTER DATABASE [StandardizedReviews] SET  MULTI_USER 
GO
ALTER DATABASE [StandardizedReviews] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StandardizedReviews] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StandardizedReviews] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StandardizedReviews] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StandardizedReviews] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'StandardizedReviews', N'ON'
GO
ALTER DATABASE [StandardizedReviews] SET QUERY_STORE = OFF
GO
USE [StandardizedReviews]
GO
/****** Object:  Table [dbo].[Episodes]    Script Date: 5/4/2020 11:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Episodes](
	[episode_id] [uniqueidentifier] NOT NULL,
	[media_id] [uniqueidentifier] NULL,
	[name] [nvarchar](max) NULL,
	[release_date] [datetime] NULL,
	[season_number] [int] NULL,
	[episode_number] [int] NULL,
	[summary_text] [nvarchar](max) NULL,
 CONSTRAINT [PK_Episodes] PRIMARY KEY CLUSTERED 
(
	[episode_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media]    Script Date: 5/4/2020 11:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[media_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](max) NULL,
	[release_date] [datetime] NULL,
	[genre] [nvarchar](max) NULL,
	[summary] [nvarchar](max) NULL,
	[media_type_id] [int] NULL,
 CONSTRAINT [PK_Media] PRIMARY KEY CLUSTERED 
(
	[media_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediaTypes]    Script Date: 5/4/2020 11:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaTypes](
	[media_type_id] [int] NOT NULL,
	[name] [nvarchar](max) NULL,
 CONSTRAINT [PK_MediaTypes] PRIMARY KEY CLUSTERED 
(
	[media_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publications]    Script Date: 5/4/2020 11:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publications](
	[publication_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](max) NULL,
	[url] [nvarchar](max) NULL,
 CONSTRAINT [PK_Publications] PRIMARY KEY CLUSTERED 
(
	[publication_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviewers]    Script Date: 5/4/2020 11:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviewers](
	[reviewer_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Reviewers] PRIMARY KEY CLUSTERED 
(
	[reviewer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StandardizedReviews]    Script Date: 5/4/2020 11:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StandardizedReviews](
	[review_id] [uniqueidentifier] NOT NULL,
	[publication_id] [uniqueidentifier] NULL,
	[reviewer_id] [uniqueidentifier] NULL,
	[media_id] [uniqueidentifier] NULL,
	[episode_id] [uniqueidentifier] NULL,
	[summary] [nvarchar](max) NULL,
	[full_text] [nvarchar](max) NULL,
	[review_score] [nvarchar](max) NULL,
	[adjusted_score] [int] NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [StandardizedReviews] SET  READ_WRITE 
GO
