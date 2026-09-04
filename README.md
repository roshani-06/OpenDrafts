# OpenDrafts

A full-stack blog web application built with Spring Boot, JSP, and MySQL — featuring a database-backed CMS, image uploads with inline paste support, session-based admin authentication, and a working contact form.

**Live demo:** https://opendrafts.onrender.com
*(Hosted on a free tier — the first load after inactivity may take 30–60 seconds to spin up.)*

---

## Features

- **Full CRUD blog posts** — create, read, update, and delete posts, backed by MySQL via Spring Data JPA
- **Image uploads** — attach a cover image per post, plus paste screenshots or copied images directly into the content editor to embed them inline between paragraphs
- **Lightweight rich text** — bold/italic formatting via a custom toolbar that wraps selected text with HTML tags
- **Session-based admin login** — Create/Edit/Delete controls are only rendered for logged-in admins; visitors get a fully read-only experience
- **Working contact form** — submissions are validated and persisted to the database, not just a static form
- **Responsive design** — custom CSS, no framework, built around a warm editorial aesthetic

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java 25, Spring Boot 4.1, Spring Data JPA (Hibernate) |
| View | JSP + JSTL |
| Database | MySQL |
| Build | Maven |
| Deployment | Docker, Render (app hosting), Clever Cloud (managed MySQL) |

## Project Structure

```
src/main/java/com/blog_web/
├── bean/            # JPA entities (Post, ContactMessage)
├── dao/              # Spring Data repositories
├── controller/        # Blogcontroller — all routes
├── config/           # WebConfig — static file serving for uploads
└── ServletInitializer.java

src/main/webapp/jsp/    # All view templates
src/main/resources/     # application.properties, static assets
```

## Running Locally

**Prerequisites:** Java 25, Maven, a local MySQL instance.

1. Clone the repo:
   ```
   git clone https://github.com/roshani-06/OpenDrafts.git
   cd OpenDrafts
   ```

2. Create a local MySQL database:
   ```sql
   CREATE DATABASE project;
   ```

3. Set the required environment variables (see table below) — either via your IDE's run configuration or your shell:
   ```
   set DB_HOST=localhost
   set DB_PORT=3306
   set DB_NAME=project
   set DB_USER=root
   set DB_PASSWORD=your_mysql_password
   set ADMIN_PASSWORD=your_chosen_admin_password
   ```

4. Run:
   ```
   mvnw spring-boot:run
   ```

5. Visit `http://localhost:8080/home`

## Environment Variables

| Variable | Description |
|---|---|
| `DB_HOST` | MySQL host |
| `DB_PORT` | MySQL port (usually `3306`) |
| `DB_NAME` | Database name |
| `DB_USER` | Database username |
| `DB_PASSWORD` | Database password |
| `ADMIN_PASSWORD` | Password required to log in and manage posts |
| `FILE_UPLOAD_DIR` | *(optional)* Directory for storing uploaded images — defaults to a local `uploads/` folder |

No credentials are hardcoded anywhere in the codebase — everything is read from environment variables at runtime.

## Deployment Notes

This app is containerized with a multi-stage Dockerfile: the first stage builds the project into a `.war` using Maven, and the second stage runs it on a minimal JRE image. It's deployed on Render, connected to a managed MySQL instance on Clever Cloud, with the connection pool capped to respect the free-tier connection limit.

## Admin Access

Post creation, editing, and deletion are gated behind a session-based login at `/admin/login` — these controls are not rendered in the HTML at all for unauthenticated visitors, not merely hidden client-side.

## Author

**Roshani Jaigude**
