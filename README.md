# Rails Task Management App

This is a simple task management application built with Ruby on Rails. The application allows users to create, edit, and delete tasks.

## Prerequisites

Before you can clone and run the project, ensure you have the following installed:

1. **Install Ruby**: Make sure Ruby is installed on your machine. You can check this by running `ruby -v`. If not installed, follow these instructions:

   - **macOS**: Use Homebrew: `brew install ruby`
   - **Windows**: Use RubyInstaller from [rubyinstaller.org](https://rubyinstaller.org/)
   - **Linux**: Use your package manager, e.g., `sudo apt-get install ruby` for Ubuntu

2. **Install Rails**: Install Rails globally by running:
   ```bash
   gem install rails
   ```

Verify installation with `rails -v`.

3. **Install PostgreSQL**: Ensure PostgreSQL is installed and running on your machine.

   - **macOS**: Use Homebrew: `brew install postgresql`
   - **Windows**: Download from [postgresql.org](https://www.postgresql.org/download/)
   - **Linux**: Use your package manager, e.g., `sudo apt-get install postgresql` for Ubuntu

4. **Install Node.js**: Install Node.js from [nodejs.org](https://nodejs.org/). Verify installation with `node -v`.

5. **Install Yarn**: Yarn is optional if you prefer npm, but recommended for Rails projects:

   ```bash
   npm install --global yarn
   ```

   Verify installation with `yarn -v`.

6. **Install Git**: Make sure Git is installed to clone repositories:
   - **macOS**: Use Homebrew: `brew install git`
   - **Windows**: Download from [git-scm.com](https://git-scm.com/download/win)
   - **Linux**: Use your package manager, e.g., `sudo apt-get install git` for Ubuntu

## Setup Instructions

Follow these steps to set up and run the project:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/luongcongduy97/rails-online.git
   cd rails-online
   ```

2. **Install Ruby Gems**

   ```bash
   bundle install
   ```

3. **Set Up the Database**

   - **Create the Database**:
     ```bash
     rake db:create
     ```
   - **Run Migrations**:
     ```bash
     rake db:migrate
     ```

4. **Install JavaScript Dependencies**

   ```bash
   yarn install
   ```

   If you're using npm instead:

   ```bash
   npm install
   ```

5. **Run the Rails Server**

   ```bash
   rails server
   ```

   Open your browser and navigate to `http://localhost:3000` to see the application running.

## Troubleshooting

If you encounter issues, try the following:

- Ensure that PostgreSQL is running (`pg_ctl -D /usr/local/var/postgres start` on macOS).
- Make sure your Ruby version matches the one specified in `.ruby-version` (if present).
- Check that Node.js and Yarn/npm are correctly installed.

## Contributing

If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are welcome.

## License

This project is licensed under the MIT License.
