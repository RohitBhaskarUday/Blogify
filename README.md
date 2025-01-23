# Blog Application with LLM Integration

## Overview
This project is a dynamic blogging application that allows users to create, enhance, and share their blog posts. It integrates advanced Large Language Model (LLM) capabilities to improve the blogging experience by providing features like content enhancement, grammar checking, SEO optimization, and more.

---

## Features

### Core Features
1. **User Management**
   - User registration and login functionality.
   - Profile management with options to update details and profile picture.

2. **Blog Post Management**
   - Create, edit, and delete blog posts.
   - Categorization of posts for better organization.

3. **Rich User Interface**
   - Responsive UI built with Bootstrap.
   - Modals for creating and enhancing posts.

### LLM Features
1. **Content Enhancement**
   - Enhance blog content using an LLM to refine language, tone, and style.
   - Interact with the LLM through a button-triggered process.

2. **Grammar Checker**
   - Real-time grammar correction for blog posts.

3. **SEO Optimization** *(Planned)*
   - Suggestions for improving blog post SEO.

4. **Multilingual Support** *(Planned)*
   - Translate blog posts into multiple languages.

---

## Project Structure

### Backend
- **Package: `com.blog`**
  - `DAO`
    - `PostDAO.java`
    - `UserDAO.java`
  - `entities`
    - `Categories.java`
    - `Message.java`
    - `Post.java`
    - `User.java`
  - `handler`
    - `ConnectionProvider.java`
    - `Handler.java`
  - `servlet`
    - `AddPostServlet.java`
    - `EditServlet.java`
    - `LoginServlet.java`
    - `LogoutServlet.java`
    - `RegisterServlet.java`
    - `EnhanceContentServlet.java`

### Frontend
- **Technologies:** HTML, CSS, JavaScript, Bootstrap
- **Key Pages:**
  - `index.jsp`: Homepage with blog post listings.
  - `profile.jsp`: User profile management.
  - `add-post-modal`: Modal for creating new blog posts.

---

## Getting Started

### Prerequisites
1. **Software:**
   - Java 8 or later
   - Apache Tomcat 9 or later
   - MySQL Server
   - Ollama (for LLM integration)

2. **Libraries/Dependencies:**
   - Gson (for JSON parsing)
   - jQuery (for AJAX requests)

3. **Database Setup:**
   - Create a MySQL database named `blogapplication`.
   - Run the SQL scripts in `schema.sql` to set up tables.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/username/blog-application.git
   cd blog-application
   ```

2. Configure the database:
   - Update `ConnectionProvider.java` with your database credentials.

3. Deploy the project:
   - Build and deploy the project on an Apache Tomcat server.

4. Run the Ollama LLM service:
   ```bash
   ollama serve
   ollama run llama3.2
   ```

---

## How It Works

### Content Enhancement Workflow
1. **Frontend:**
   - User writes content in the field and hits the "Enhance Content" button.
   - AJAX sends the content to `EnhanceContentServlet`.

2. **Backend:**
   - The servlet sends the content as a prompt to the Ollama LLM server.
   - The response is parsed and cleaned to provide a refined version of the content.

3. **Frontend:**
   - The enhanced content is displayed in the field for the user to review and post.

---

## Future Enhancements
1. **Advanced SEO Suggestions**
   - Keyword density analysis.
   - Readability scoring.

2. **Multilingual Support**
   - Translation of blog posts into selected languages.

3. **AI-Powered Idea Generation**
   - Suggest blog topics based on user preferences and trends.

---

## Acknowledgments
- [Bootstrap](https://getbootstrap.com/) for frontend styling.
- [Ollama LLM](https://ollama.ai/) for content enhancement capabilities.
- [jQuery](https://jquery.com/) for AJAX interactions.

