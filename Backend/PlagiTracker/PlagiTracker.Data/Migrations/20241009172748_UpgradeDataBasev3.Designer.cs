﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using PlagiTracker.Data.DataAccess;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    [DbContext(typeof(DataContext))]
    [Migration("20241009172748_UpgradeDataBasev3")]
    partial class UpgradeDataBasev3
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("PlagiTracker.Data.Entities.Assignment", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("AnalysisDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("CourseId")
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .HasMaxLength(250)
                        .HasColumnType("character varying(250)");

                    b.Property<bool>("IsAnalyzed")
                        .HasColumnType("boolean");

                    b.Property<DateTime>("SubmissionDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.HasKey("Id");

                    b.HasIndex("CourseId");

                    b.HasIndex("Title")
                        .IsUnique();

                    b.ToTable("Assignments");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Code", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("FileName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.Property<Guid>("SubmissionId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("SubmissionId", "FileName")
                        .IsUnique();

                    b.ToTable("Codes");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Course", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(80)
                        .HasColumnType("character varying(80)");

                    b.Property<Guid>("TeacherId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("TeacherId");

                    b.ToTable("Courses");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Enrollment", b =>
                {
                    b.Property<Guid>("StudentId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("CourseId")
                        .HasColumnType("uuid");

                    b.Property<double>("Grade")
                        .HasColumnType("decimal(4, 2)");

                    b.HasKey("StudentId", "CourseId");

                    b.HasIndex("CourseId");

                    b.ToTable("Enrollments");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Plagiarism", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int>("Algorithm")
                        .HasColumnType("integer");

                    b.Property<Guid>("CodeId")
                        .HasColumnType("uuid");

                    b.Property<string>("CodeSnippet")
                        .HasColumnType("text");

                    b.Property<int>("Coincidences")
                        .HasColumnType("integer");

                    b.Property<double>("Similarity")
                        .HasColumnType("decimal(5, 2)");

                    b.HasKey("Id");

                    b.HasIndex("CodeId", "Algorithm")
                        .IsUnique();

                    b.ToTable("Plagiarisms");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Submission", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("AssignmentId")
                        .HasColumnType("uuid");

                    b.Property<double>("Grade")
                        .HasColumnType("decimal(4, 2)");

                    b.Property<Guid>("StudentId")
                        .HasColumnType("uuid");

                    b.Property<DateTime>("SubmissionDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Url")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("AssignmentId");

                    b.HasIndex("Url")
                        .IsUnique();

                    b.HasIndex("StudentId", "AssignmentId")
                        .IsUnique();

                    b.ToTable("Submissions");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.User", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(35)
                        .HasColumnType("character varying(35)");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasMaxLength(40)
                        .HasColumnType("character varying(40)");

                    b.Property<bool>("IsLocked")
                        .HasColumnType("boolean");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasMaxLength(40)
                        .HasColumnType("character varying(40)");

                    b.Property<int>("LogInAttempts")
                        .HasColumnType("integer");

                    b.Property<byte[]>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("bytea");

                    b.Property<DateTime>("UnlockDate")
                        .HasColumnType("timestamp with time zone");

                    b.HasKey("Id");

                    b.HasIndex("Email")
                        .IsUnique();

                    b.ToTable("Users");

                    b.UseTptMappingStrategy();
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Student", b =>
                {
                    b.HasBaseType("PlagiTracker.Data.Entities.User");

                    b.ToTable("Students", (string)null);
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Teacher", b =>
                {
                    b.HasBaseType("PlagiTracker.Data.Entities.User");

                    b.ToTable("Teachers", (string)null);
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Assignment", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.Course", "Course")
                        .WithMany()
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Course");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Code", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.Submission", "Submission")
                        .WithMany()
                        .HasForeignKey("SubmissionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Submission");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Course", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.Teacher", "Teacher")
                        .WithMany()
                        .HasForeignKey("TeacherId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Teacher");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Enrollment", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.Course", "Course")
                        .WithMany()
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("PlagiTracker.Data.Entities.Student", "Student")
                        .WithMany()
                        .HasForeignKey("StudentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Course");

                    b.Navigation("Student");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Plagiarism", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.Code", "Code")
                        .WithMany()
                        .HasForeignKey("CodeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Code");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Submission", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.Assignment", "Assignment")
                        .WithMany()
                        .HasForeignKey("AssignmentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("PlagiTracker.Data.Entities.Student", "Student")
                        .WithMany()
                        .HasForeignKey("StudentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Assignment");

                    b.Navigation("Student");
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Student", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.User", null)
                        .WithOne()
                        .HasForeignKey("PlagiTracker.Data.Entities.Student", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("PlagiTracker.Data.Entities.Teacher", b =>
                {
                    b.HasOne("PlagiTracker.Data.Entities.User", null)
                        .WithOne()
                        .HasForeignKey("PlagiTracker.Data.Entities.Teacher", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}